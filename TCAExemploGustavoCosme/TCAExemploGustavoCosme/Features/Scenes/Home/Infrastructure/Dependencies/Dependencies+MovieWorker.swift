//
//  MovieWorkerKey.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 19/10/25.
//

import ComposableArchitecture

extension DependencyValues {
    var movieWorker: MovieWorkerProtocol {
        get { self[MovieWorkerKey.self] }
        set { self[MovieWorkerKey.self] = newValue }
    }

    private enum MovieWorkerKey: DependencyKey {
        static let liveValue: MovieWorkerProtocol = MovieWorker()
        static let mockValue: MovieWorkerProtocol = MovieWorkerMock()
    }
}
