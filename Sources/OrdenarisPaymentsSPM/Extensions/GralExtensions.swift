//
//  GralExtensions.swift
//  OrdenarisPaymentsSPM
//
//  Created by Ignacio Hernández on 11/11/24.
//

import Foundation

// MARK: - Bundle Extension
extension Bundle {
    static var mySwiftPackageBundle: Bundle? {
        // Devuelve el Bundle donde se encuentra la clase `CustomView`
        let bundle = Bundle.module
        return bundle
    }
}
