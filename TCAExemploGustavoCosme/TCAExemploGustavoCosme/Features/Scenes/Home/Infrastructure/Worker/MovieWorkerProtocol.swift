//
//  MovieWorkerProtocol.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 19/10/25.
//

protocol MovieWorkerProtocol {
    func fetchMovies(page: Int) async -> Result<MovieResponse?, BaseError>
}
