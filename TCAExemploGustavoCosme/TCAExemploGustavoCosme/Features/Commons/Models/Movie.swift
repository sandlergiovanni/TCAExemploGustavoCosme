//
//  Movie.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 18/10/25.
//

import Foundation

struct Movie: Identifiable, Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double?
    let voteCount: Int?
    
    var posterUrlPath: String? {
        guard let path = posterPath else { return nil }
        return "https://image.tmdb.org/t/p/w500\(path)"
    }
}
