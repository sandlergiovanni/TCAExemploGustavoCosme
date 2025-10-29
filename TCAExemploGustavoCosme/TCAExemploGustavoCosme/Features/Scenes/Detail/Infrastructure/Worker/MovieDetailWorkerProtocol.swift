//
//  MovieDetailWorkerProtocol.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 28/10/25.
//

protocol MovieDetailWorkerProtocol {
    typealias MovieDetailResult = Result<Movie?, BaseError>

    func fetchMovieDetails(of id: Int) async -> MovieDetailResult
}
