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
