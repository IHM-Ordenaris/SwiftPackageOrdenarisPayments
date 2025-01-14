// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
@preconcurrency import WebKit

/// Clase ejemplo para Test
public struct OrdenarisPaymentsExample {
    public var text = "Hello, Swift Package!"
    public init() {}
    public func hello() -> String {
        return text
    }
}

/// Clase principal Swift Package Manager
public class OrdenarisPaymentsSPM: NSObject,  @unchecked Sendable {
    // MARK: - Variables públicas
    public var delegate: OrdenarisPaymentsDelegate?
    
    // MARK: - Variables privadas
    private var vista: OPViewPayments
    private var entorno: Scheme
    private var printEvents: Bool
    private var counterErrorPayment: Int
    private var timer: Timer
    private var counterSeconds: Int
    
    // MARK: - Inicializadores
    public init(view: OPViewPayments, _ scheme: Scheme = .PROD, _ printEvents: Bool = false) {
        self.vista = view
        self.entorno = scheme
        self.counterErrorPayment = 0
        self.timer = Timer()
        self.counterSeconds = 0
        self.printEvents = printEvents
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Funciones PÚBLICAS
    /// Función para crear orden de pago
    /// - Parameter printResponse: Valor que indica si se imprime en consola el response del Request
    @MainActor public func createOrder( _ printResponse: Bool = false) {
        self.configureLog()
        self.callServiceCreatePaymentOrder(printResponse) { response, error in
            if let _ = response {
                if (response?.success)! {
                    self.delegate?.responseSuccess()
                    if let urlStr = response?.data?.url {
                        let url = URL(string: urlStr)!
                        self.loadWebView(url: url)
                    }
                } else {
                    print("ERROR")
                }
            }else {
                self.delegate?.responseError(code: (error?.statusCode)!, (error?.message)!)
            }
        }
    }
    
    // MARK: - Funciones PRIVADAS
    /// Función que configura el LOG a escuchar de la consola Web
    private func configureLog(){
        DispatchQueue.main.async {
            self.vista.webView.configuration.userContentController.add(self, name: "logHandler")
        }
    }
    
    /// Función que carga la URL de la orden de pago obtenida del servicio
    /// - Parameter url: URL obtenida de la respuesta de servicio
    private func loadWebView(url: URL) {
        DispatchQueue.main.async {
            if self.printEvents {
                print("cargando url: \(url.absoluteString)")
            }
            self.vista.webView.load(URLRequest(url: url))
        }
    }
    
    /// Función que consume el servicio de crear orden de pago
    /// - Parameters:
    ///   - printResponse: Valor que indica si se imprime el log del response en consola
    ///   - callback: ObjCreateOrderResponse (⎷ response) / ErrorResponse (⌀ error)
    @MainActor private func callServiceCreatePaymentOrder(_ printResponse: Bool = true, _ callback: @escaping CallbackResponseTarget) {
        let objApp = self.vista.objApp
        let objCre = self.vista.credentials
        let objOrd = self.vista.order
        
        let newBodyRequest = ObjCreateOrder(apl: objApp, cre: objCre, ord: objOrd)
        var urlStr = Constants.Request.Url.paymentsPROD
        if self.entorno == .QA {
            urlStr = Constants.Request.Url.paymentsQA
        }
        
        do {
            let encoder = JSONEncoder()
            let bodyData = try encoder.encode(newBodyRequest)
            
            let url = URL(string: urlStr)!
            var request = URLRequest(url: url)
            request.httpMethod = Constants.Request.Method.post
            
            var body: Data?
            if let data = bodyData as? Data{
                body = data
            }
            request.httpBody = body
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.cachePolicy = .reloadIgnoringLocalCacheData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print("❌ Error en servicio Crear Orden de Pago")
                    var err: ErrorResponse = ErrorResponse()
                    switch error {
                    case .some(let error as NSError) where error.code == NSURLErrorNotConnectedToInternet: // showOffline
                        err.statusCode = error.code
                        err.message = error.localizedDescription
                    case .some(let error as NSError) where error.code == NSURLErrorTimedOut: // Timed Out
                        err.statusCode = error.code
                        err.message = error.localizedDescription
                    case .some(let error as NSError): // showGenericError
                        err.statusCode = error.code
                        err.message = error.localizedDescription
                    case .none:
                        print("none")
                    }
                    callback(nil, err)
                    return
                }
                
                guard let responseG = response as? HTTPURLResponse, 200 ... 299  ~= responseG.statusCode else {
                    DispatchQueue.main.async {
                        print("❌ Error en servicio Crear Orden de Pago...")
                        print("Response: \(String(describing: response))")
                        var err = ErrorResponse()
                        err.success = false
                        err.message = Constants.Response.Message.errorDisponible
                        let resp = response as! HTTPURLResponse
                        err.statusCode = resp.statusCode
                        callback(nil, err)
                    }
                    return
                }
                
                print("✅ Responde el servicio Crear Orden de Pago")
                do {
                    let createResponse = try JSONDecoder().decode(ObjCreateOrderResponse.self, from: data)
                    if printResponse {
                        print("RESPONSE:\n\(createResponse)")
                    }
                    callback(createResponse, nil)
                } catch {
                    print("No se pudo parsear el objeto de Crear Orden")
                    var error = ErrorResponse()
                    error.statusCode = -2
                    error.message = Constants.Response.Message.errorParseo
                    callback(nil, error)
                }
            }
            print("Request a Servicio Crear Orden de Pago...")
            task.resume()
        } catch {
            var error = ErrorResponse()
            error.statusCode = -2
            error.success = false
            error.message = Constants.Response.Message.errorDatos
            error.id = ""
            callback(nil, error)
        }
    }
}

// MARK: - WKScriptMessageHandler Delegate
extension OrdenarisPaymentsSPM: WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == Constants.Script.handler {
            if self.printEvents {
                print("\nWEB LOG: \(message.body)")
            }
            if let jsonString = message.body as? String {
                if jsonString.contains("{") {
                    if let jsonData = jsonString.data(using: .utf8) {
                        do {
                            let obj = try JSONDecoder().decode(LogWeb.self, from: jsonData)
                            self.actionToLogWeb(logWeb: obj, obj: message.body)
                        } catch {
                            print("Error al decodificar el JSON: \(error.localizedDescription)")
                        }
                    } else {
                        print("Error al convertir el string a Data")
                    }
                }
            }
        }
    }
    
    func actionToLogWeb(logWeb: LogWeb, obj: Any) {
        if let event = logWeb.event {
            switch event {
            // :::::: Optional Events :::::
            case EventWeb.componentInitialization.rawValue:
                self.delegate?.event_ComponentInitialization?(obj)
            case EventWeb.loadingPaymentData.rawValue:
                self.delegate?.event_LoadingPaymentData?(obj)
            case EventWeb.paymentDataLoad.rawValue:
                self.delegate?.event_PaymentDataLoad?(obj)
            case EventWeb.loadingPaymentForm.rawValue:
                self.delegate?.event_LoadingPaymentForm?(obj)
            case EventWeb.paymentFormLoad.rawValue:
                self.delegate?.event_PaymentFormLoad?(obj)
            case EventWeb.paymentDataLoadError.rawValue:
                self.delegate?.event_PaymentDataLoadError?(obj)
            case EventWeb.requestTokenCreate.rawValue:
                self.delegate?.event_RequestTokenCreate?(obj)
            case EventWeb.tokenCreate.rawValue:
                self.delegate?.event_TokenCreate?(obj)
            case EventWeb.captureInit.rawValue:
                self.delegate?.event_CaptureInit?(obj)
            case EventWeb.captureCancel.rawValue:
                self.delegate?.event_CaptureCancel?(obj)
            case EventWeb.errorToShowCheckout.rawValue:
                self.delegate?.event_ErrorToShowCheckout?(obj)
            case EventWeb.errorOnloadScript.rawValue:
                self.delegate?.event_ErrorOnloadScript?(obj)
            case EventWeb.changeRecurrence.rawValue:
                self.delegate?.event_ChangeRecurrence?(obj)
            case EventWeb.changeOnForm.rawValue:
                self.delegate?.event_ChangeOnForm?(obj)
            case EventWeb.goToDetail.rawValue:
                self.delegate?.event_GoToDetail?(obj)
            case EventWeb.requestPayment.rawValue:
                self.delegate?.event_RequestPayment?(obj)
            
            // :::::: Forced Events :::::
            case EventWeb.paymentSuccess.rawValue:
                self.delegate?.event_PaymentSuccess(obj)
                self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    DispatchQueue.main.async {
                        if self.counterSeconds != self.vista.returnDelay {
                            self.counterSeconds += 1
                        } else {
                            self.counterSeconds = 0
                            self.timer.invalidate()
                            self.delegate?.event_ReturnToApp("Return to app for returnDelay complete")
                        }
                    }
                }
            case EventWeb.paymentError.rawValue:
                self.delegate?.event_PaymentError(obj)
                if self.counterErrorPayment != 2 {
                    self.counterErrorPayment += 1
                } else {
                    self.counterErrorPayment = 0
                    self.delegate?.event_ReturnToApp(obj)
                }
            case EventWeb.returnToApp.rawValue:
                self.delegate?.event_ReturnToApp(obj)
            case EventWeb.cancelRecharge.rawValue :
                self.delegate?.event_CancelRecharge(obj)
            default:
                print("Sin acción para el evento Web...")
            }
        }
    }
}
