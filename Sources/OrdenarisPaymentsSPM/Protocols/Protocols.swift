//
//  Protocols.swift
//  OrdenarisPaymentsSPM
//
//  Created by Ignacio Hernández on 11/11/24.
//

import Foundation

//MARK: - Protocol OrdenarisPaymentsDelegate
@objc public protocol OrdenarisPaymentsDelegate{
    @objc optional func Event_ComponentInitialization(_ objReturn: Any)
    @objc optional func Event_LoadingPaymentData(_ objReturn: Any)
    @objc optional func Event_PaymentDataLoad(_ objReturn: Any)
    @objc optional func Event_LoadingPaymentForm(_ objReturn: Any)
    @objc optional func Event_PaymentFormLoad(_ objReturn: Any)
    @objc optional func Event_PaymentDataLoadError(_ objReturn: Any)
    @objc optional func Event_RequestTokenCreate(_ objReturn: Any)
    @objc optional func Event_TokenCreate(_ objReturn: Any)
    @objc optional func Event_CaptureInit(_ objReturn: Any)
    @objc optional func Event_CaptureCancel(_ objReturn: Any)
    @objc optional func Event_ErrorToShowCheckout(_ objReturn: Any)
    @objc optional func Event_ErrorOnloadScript(_ objReturn: Any)
    @objc optional func Event_ChangeRecurrence(_ objReturn: Any)
    @objc optional func Event_ChangeOnForm(_ objReturn: Any)
    @objc optional func Event_GoToDetail(_ objReturn: Any)
    @objc optional func Event_RequestPayment(_ objReturn: Any)
    @objc func Event_PaymentSuccess(_ objReturn: Any)
    @objc func Event_PaymentError(_ objReturn: Any)
    @objc func Event_ReturnToApp(_ objReturn: Any)
    @objc func Event_CancelRecharge(_ objReturn: Any)
    
    /// Se ejecuta cuando el servicio responde un error
    /// - Parameters:
    ///   - code: código del error
    ///   - message: Mensaje del error
    @objc func ResponseError(code: Int,_ message: String)
    /// Se ejecuta cuando el servicio responde correctamente
    @objc func ResponseSuccess()
}
