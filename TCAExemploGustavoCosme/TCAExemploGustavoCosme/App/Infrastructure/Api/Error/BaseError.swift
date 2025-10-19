//
//  BaseError.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 18/10/25.
//

struct BaseError: Codable, Equatable, Error {
    let errorMessage: String
    let errorCode: Int
    
    init(errorMessage: String, errorCode: Int = -1) {
        self.errorMessage = errorMessage
        self.errorCode = errorCode
    }
}
