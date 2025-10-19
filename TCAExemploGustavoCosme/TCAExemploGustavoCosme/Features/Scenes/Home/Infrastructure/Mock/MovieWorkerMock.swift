//
//  MovieWorkerMock.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 19/10/25.
//

struct MovieWorkerMock: MovieWorkerProtocol {
    private(set) var result: MovieResponse?
    private(set) var resultError: BaseError?

    func fetchMovies(page: Int) async -> Result<MovieResponse?, BaseError> {
        if let result {
            return .success(result)
        }
        if let resultError {
            return .failure(resultError)
        }
        return .failure(BaseError(errorMessage: "Unknown error"))
    }
}
