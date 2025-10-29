//
//  MovieDetailWorker.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 28/10/25.
//

import Foundation

struct MovieDetailWorker: MovieDetailWorkerProtocol {
    private let service: ApiClient = ApiClient()
    private let path: String = "movie/"
    
    func fetchMovieDetails(of id: Int) async -> MovieDetailResult {
        let queryParameters: [URLQueryItem] = []
        let moviePath = "\(self.path)\(id)"
        let result: MovieDetailResult = await service.fetchData(path: moviePath,
                                                                extraQueryParams: queryParameters)
        return result
    }
}
