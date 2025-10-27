//
//  MovieWorkerProtocol.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 19/10/25.
//

protocol MovieWorkerProtocol {
    typealias MovieResult = Result<MovieResponse?, BaseError>

    func fetchMovies(page: Int) async -> MovieResult
}
