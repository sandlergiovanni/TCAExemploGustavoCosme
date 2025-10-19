//
//  MovieResponse.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 18/10/25.
//

struct MovieResponse: Codable, Equatable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
