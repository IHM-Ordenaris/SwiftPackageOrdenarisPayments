//
//  PaymentObjects.swift
//  OrdenarisPaymentsSPM
//
//  Created by Ignacio Hernández on 29/10/24.
//

import Foundation

// MARK: - Objetos ENCODE
internal struct ObjCreateOrder: Codable {
    var aplication: ObjApplication
    var credentials: ObjCredentials
    var orden: ObjOrden
    init(apl: ObjApplication, cre: ObjCredentials, ord: ObjOrden) {
        aplication = apl
        credentials = cre
        orden = ord
    }
}

public struct ObjApplication: Codable {
    var returnDelay: Int            // Opcional - Segundos que mostrarán en el contador antes de regresar a la vista
    var returnText: String          // Opcional - Texto a mostrar que generará un evento "ReturnToApp"
    var redirectText: String        // Opcional - Texto que se mostrará a un costado del contador
    var storeName : String          // Nombre de la tienda
    var storeImage : String         // Icono de la tienda a mostrar
    internal let origin : String    // Obligatorio para apps indica el nombre de la propiedad principal
    var hideReturnArrow : Bool      // Valor que muestra u oculta la flecha de regresar
    var showReturnButton : Bool     // Valor que muestra u oculta el botón de regresar
    public init() {
        returnDelay = 5
        returnText = "Volver a la app"
        redirectText = "Volviendo a la app en"
        storeName = "Store Name"
        storeImage = "https://ordenaris.com/img/logo.png"
        origin = "app"
        hideReturnArrow = false
        showReturnButton = true
    }
    
//    init(returnDelay: int, apiPage:String, llavero: String) {
//        self.returnDelay = returnDelay
//        self.apiPage = apiPage
//        self.llavero = llavero
//    }
}

public struct ObjCredentials: Codable {
    public var store: String      // Identificador de la tienda
    public var channel: String    // Identificador del canal de consulta
    init() {
        store = ""
        channel = ""
    }
}

public struct ObjOrden: Codable {
    internal var campaign: String?      // Solo aplica para Web, texto de campaña a mostrar
    public var total: Double            // Valor total de la venta
    public var orderId: String          // Identificador de la oferta
    public  var reference1: String      // DN del beneficiario
    public var reference2: String       // Identificador de la oferta
    public var reference3: Double       // Precio de de la oferta
    public var reference4: String       // Perfil
    public var reference5: String       // email del beneficiario
    public var products: [ObjProduct]   // Arreglo de productos a vender
    public var customer: ObjCustomer    // Información del cliente
    init() {
        campaign = nil
        total = 0
        orderId = ""
        reference1 = ""
        reference2 = ""
        reference3 = 0
        reference4 = ""
        reference5 = ""
        products = []
        customer = ObjCustomer()
    }
}

public struct ObjProduct: Codable {
    public var name: String        // Nombre de la oferta
    public var uuid: String        // Identificador de la oferta
    public var description: String // Descripción de la oferta
    public var quantity: Int       // Unidades a comprar
    public var price: Double       // Precio por unidad
    public var validity: Int       // Vigencia en días
    public var image: String       // Imágen de la oferta
    public init() {
        name = ""
        uuid = ""
        description = ""
        quantity = 0
        price = 0
        validity = 0
        image = ""
    }
}

public struct ObjCustomer: Codable {
    public var name: String    // Nombre del cliente
    public var email: String   // Email del cliente
    public var phone: String   // Teléfono del cliente
    public var logged: String  // Valor que inidica si tiene sesión
    public init() {
        name = ""
        email = ""
        phone = ""
        logged = "true"
    }
}
