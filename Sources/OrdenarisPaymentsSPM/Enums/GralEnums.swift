//
//  GralEnums.swift
//  OrdenarisPaymentsSPM
//
//  Created by Ignacio Hernández on 11/11/24.
//

import Foundation

// MARK: - Enum Web Events
internal enum EventWeb: String {
    case componentInitialization = "ComponentInitialization"
    case loadingPaymentData = "LoadingPaymentData"
    case paymentDataLoad = "PaymentDataLoad"
    case loadingPaymentForm = "LoadingPaymentForm"
    case paymentFormLoad = "PaymentFormLoad"
    case paymentDataLoadError = "PaymentDataLoadError"
    case requestTokenCreate = "RequestTokenCreate"
    case tokenCreate = "TokenCreate"
    case captureInit = "CaptureInit"
    case captureCancel = "CaptureCancel"
    case errorToShowCheckout = "ErrorToShowCheckout"
    case errorOnloadScript = "ErrorOnloadScript"
    case changeRecurrence = "ChangeRecurrence"
    case changeOnForm = "ChangeOnForm"
    case goToDetail = "GoToDetail"
    case requestPayment = "RequestPayment"
    case paymentSuccess = "PaymentSuccess"
    case paymentError = "PaymentError"
    case returnToApp = "ReturnToApp"
    case cancelRecharge = "CancelRecharge"
}
