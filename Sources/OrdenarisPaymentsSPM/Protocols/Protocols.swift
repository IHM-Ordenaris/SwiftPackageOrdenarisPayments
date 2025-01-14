//
//  Protocols.swift
//  OrdenarisPaymentsSPM
//
//  Created by Ignacio Hernández on 11/11/24.
//

import Foundation

//MARK: - Protocol OrdenarisPaymentsDelegate
@objc public protocol OrdenarisPaymentsDelegate{
    @objc optional func event_ComponentInitialization(_ objReturn: Any)
    @objc optional func event_LoadingPaymentData(_ objReturn: Any)
    @objc optional func event_PaymentDataLoad(_ objReturn: Any)
    @objc optional func event_LoadingPaymentForm(_ objReturn: Any)
    @objc optional func event_PaymentFormLoad(_ objReturn: Any)
    @objc optional func event_PaymentDataLoadError(_ objReturn: Any)
    @objc optional func event_RequestTokenCreate(_ objReturn: Any)
    @objc optional func event_TokenCreate(_ objReturn: Any)
    @objc optional func event_CaptureInit(_ objReturn: Any)
    @objc optional func event_CaptureCancel(_ objReturn: Any)
    @objc optional func event_ErrorToShowCheckout(_ objReturn: Any)
    @objc optional func event_ErrorOnloadScript(_ objReturn: Any)
    @objc optional func event_ChangeRecurrence(_ objReturn: Any)
    @objc optional func event_ChangeOnForm(_ objReturn: Any)
    @objc optional func event_GoToDetail(_ objReturn: Any)
    @objc optional func event_RequestPayment(_ objReturn: Any)
    @objc func event_PaymentSuccess(_ objReturn: Any)
    @objc func event_PaymentError(_ objReturn: Any)
    @objc func event_ReturnToApp(_ objReturn: Any)
    @objc func event_CancelRecharge(_ objReturn: Any)
    
    /// Se ejecuta cuando el servicio responde un error
    /// - Parameters:
    ///   - code: código del error
    ///   - message: Mensaje del error
    @objc func responseError(code: Int,_ message: String)
    /// Se ejecuta cuando el servicio responde correctamente
    @objc func responseSuccess()
}
