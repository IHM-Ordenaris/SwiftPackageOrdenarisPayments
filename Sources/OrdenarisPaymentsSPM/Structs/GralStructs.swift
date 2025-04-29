//
//  GralStructs.swift
//  OrdenarisPaymentsSPM
//
//  Created by Ignacio Hernández on 11/11/24.
//

import Foundation

// MARK: - Estruct LogWeb
internal struct LogWeb: Codable {
    var type: String?
    var event: String?
    var loading: Bool?
    var message: String?
}

// MARK: - Constants
struct Constants {
    // Request
    struct Request {
        struct Url {
            static var paymentsPROD: String {
                return "https://pagos.ordenaris.com/paynow/app/v1/payment/order/create"
//                return "https://pagos.ordenaris.com/ordenPago/payment/order/create"
            }
            static var paymentsQA: String {
                return "https://pagosqa.ordenaris.com/ordenPago/payment/order/create"
            }
        }
        
        struct Method {
            static var post: String {
                return "POST"
            }
        }
    }
    
    // Error Messages
    struct Response {
        struct Message {
            static var errorDisponible: String {
                return "Lo sentimos, este servicio no está disponible."
            }
            static var errorParseo: String {
                return "No se pudo parsear el objeto de Crear Orden de Pago"
            }
            static var errorDatos: String {
                return "Los datos a enviar son incorrectos"
            }
        }
    }
    
    // Logs
    struct Script {
        static var captureLog: String {
            return "function captureLog(msg) { window.webkit.messageHandlers.logHandler.postMessage(msg); } window.console.log = captureLog;"
        }
        static var handler: String {
            return "logHandler"
        }
    }
}
