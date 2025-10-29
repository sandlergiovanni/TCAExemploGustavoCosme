//
//  Dependencies+MovieDetailsWorker.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 28/10/25.
//

import ComposableArchitecture

extension DependencyValues {
    var movieDetailsWorker: MovieDetailWorkerProtocol {
        get { self[MovieDetailsWorkerKey.self] }
        set { self[MovieDetailsWorkerKey.self] = newValue }
    }
    
    private enum MovieDetailsWorkerKey: DependencyKey {
        static let liveValue: MovieDetailWorkerProtocol = MovieDetailWorker()
        static let mockValue: MovieDetailWorkerProtocol = MovieDetailWorkerMock()
    }
}
