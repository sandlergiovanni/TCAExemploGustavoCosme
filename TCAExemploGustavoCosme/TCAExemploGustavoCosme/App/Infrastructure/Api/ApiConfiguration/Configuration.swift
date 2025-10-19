//
//  Configuration.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 18/10/25.
//

struct Configuration: Codable {
    struct Images: Codable {
        let baseURL: String
        let secureBaseURL: String
        let posterSizes: [String]
    }
    let images: Images
    let changeKeys: [String]?
}
