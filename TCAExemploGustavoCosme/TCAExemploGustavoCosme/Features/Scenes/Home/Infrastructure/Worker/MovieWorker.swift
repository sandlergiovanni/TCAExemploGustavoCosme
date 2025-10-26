//
//  MovieWorker.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 19/10/25.
//

import Foundation

struct MovieWorker: MovieWorkerProtocol {
    typealias MovieResult = Result<MovieResponse?, BaseError>

    private var service: ApiClient = ApiClient()
    private var path: String = "movie/popular"

    func fetchMovies(page: Int) async -> Result<MovieResponse?, BaseError> {
        let queryParameters: [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        let result: MovieResult = await service.fetchData(path: self.path,
                                                          extraQueryParams: queryParameters)
        return result
    }
}
