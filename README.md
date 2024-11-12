# OrdenarisPayments
OrdenarisPayments es un paquete que facilita la implementación de la vista de pagos dentro de las aplicaciones iOS

![ESTabBarController](https://ordenaris.com/img/logo.png)

[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-orange.svg)](#swift-package-manager)
[![Swift v5](https://img.shields.io/badge/Swift-5-orange.svg?style=flat)](https://developer.apple.com/swift/)

## Requirements
* Xcode 8 o posterior
* iOS v14.0 o posterior

## Installation
### Swift Package Manager

Para instalar el paquete, puedes agregar el siguiente enlace en el campo de dependencias de Swift Package Manager: https://github.com/IHM-Ordenaris/SwiftPackageOrdenarisPayments.git

## Example

Paso 1:
Importar el paquete y agregar la vista de pagos de tipo OPViewPayments.

    import OrdenarisPaymentsSPM
    @IBOutlet weak var viewPayments: OPViewPayments!
    
Paso 2: 
Configurar las propiedades de la vista.

        // MARK: 1 - Config View Payments
        self.viewPayments.returnDelay = 15  //(seconds)
        self.viewPayments.returnText = "Volver a la app"
        self.viewPayments.redirectText = "Volviendo a la app en"
        self.viewPayments.storeName = "App Name"
        self.viewPayments.storeImageUrl = "https://ordenaris.com/img/logo.png"
        self.viewPayments.showReturnArrow = true
        self.viewPayments.showReturnButton = true
        
        // 1.1 - Object credentials (Proporcionados por Ordenaris)
        self.viewPayments.credentials.store = "???????" 
        self.viewPayments.credentials.channel = "?????"
        
        // 1.2 - Object Order
        self.viewPayments.order.total = 200
        self.viewPayments.order.orderId = "0123456789"
        self.viewPayments.order.reference1 = "9876543210"
        self.viewPayments.order.reference2 = "0123456789"
        self.viewPayments.order.reference3 = 200
        self.viewPayments.order.reference4 = "mbb"
        self.viewPayments.order.reference5 = "example@gmail.com"
        var product = ObjProduct()
        product.name = "Recarga $200"
        product.uuid = "0123456789"
        product.description = "Obten 15GB de navegación por 30 días."
        product.quantity = 1
        product.price = 200
        product.validity = 30
        product.image = "https://ordenaris.com/img/logo.png"
        self.viewPayments.order.products.append(product)
        var customer = ObjCustomer()
        customer.name = "Ignacio"
        customer.email = "ignacio.hernandez@ordenaris.com"
        customer.phone = "5500112233"
        self.viewPayments.order.customer = customer
        
        //MARK: 2 - Delegate & Create Order
        let payments = OrdenarisPaymentsSPM(view: self.viewPayments, true)
        payments.delegate = self
        payments.createOrder()
        
    Paso 3:  
    Implementar el método delegado para el manejo de acciones.
    
        extension AppExampleController: OrdenarisPaymentsDelegate {
            func ResponseSuccess() {
                print("✅ Response Success - Crear orden de pago")
            }
            func ResponseError(code: Int, _ message: String) {
                print("🚫 \(message) - \(code)")
            }
            func Event_PaymentSuccess(_ objReturn: Any) {
                print("🔔 Payment Success")
            }
            func Event_PaymentError(_ objReturn: Any) {
                print("🔔 Payment Error")
            }
            func Event_ReturnToApp(_ objReturn: Any) {
                print("🔔 Return to app")
            }
            func Event_CancelRecharge(_ objReturn: Any) {
                print("🔔 Cancel Recharge")
            }
        }

## Author
Ignacio Hernández, ignacio.hernandez@ordenaris.com

## License
OrdenarisPayments is available under the MIT license.
