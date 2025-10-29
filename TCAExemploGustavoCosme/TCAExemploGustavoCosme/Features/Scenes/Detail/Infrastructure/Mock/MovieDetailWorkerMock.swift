//
//  MovieDetailWorkerMock.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 28/10/25.
//

struct MovieDetailWorkerMock: MovieDetailWorkerProtocol {
    private(set) var result: Movie?
    private(set) var resultError: BaseError?

    func fetchMovieDetails(of id: Int) async -> MovieDetailResult {
        if let result {
            return .success(result)
        }
        if let resultError {
            return .failure(resultError)
        }
        return .failure(BaseError(errorMessage: "Unknown error"))
    }
}
