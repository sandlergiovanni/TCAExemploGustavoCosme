//
//  MovieWorker.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 19/10/25.
//

import Foundation

struct MovieWorker: MovieWorkerProtocol {
    private let service: ApiClient = ApiClient()
    private var path: String = "movie/popular"

    func fetchMovies(page: Int) async -> MovieResult {
        let queryParameters: [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        let result: MovieResult = await service.fetchData(path: self.path,
                                                          extraQueryParams: queryParameters)
        return result
    }
}
