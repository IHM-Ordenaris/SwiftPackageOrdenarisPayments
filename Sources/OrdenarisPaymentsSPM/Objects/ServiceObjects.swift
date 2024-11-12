//
//  ServiceObjects.swift
//  OrdenarisPaymentsSPM
//
//  Created by Ignacio Hernández on 30/10/24.
//

import Foundation

// MARK: - Objetos response SUCCESS
public typealias CallbackResponseTarget = @Sendable (_ response: ObjCreateOrderResponse?, _ error: ErrorResponse?) -> ()

public struct ObjCreateOrderResponse: Decodable {
    public let success: Bool?
    public let data: responseData?
    
    init() {
        success = true
        data = responseData()
    }
}

public struct responseData: Decodable {
    public let url: String?
    init() {
        url = ""
    }
}

// MARK: - Objetos response ERROR
public struct ErrorResponse: Codable, Error {
    public var statusCode: Int?
    public var success: Bool?
    public var message: String?
    public var id: String?
    
    enum CodingKeys: Int, CodingKey {
        case statusCode
        case success
        case message
        case id
    }
    init() {
        statusCode = 0
        success = false
        message = ""
        id = ""
    }
}

