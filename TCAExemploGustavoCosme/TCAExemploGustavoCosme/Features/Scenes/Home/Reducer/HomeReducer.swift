//
//  HomeReducer.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 19/10/25.
//

import ComposableArchitecture

@Reducer
struct HomeReducer {
    @ObservableState
    struct State: Equatable {
        var page: Int = 1
        var movies: [Movie] = []
        var errorMessage: String? = nil
        var isLoading: Bool = false
    }
    
    enum Action: Equatable {
        case onAppear
        case moviesLoaded([Movie]?)
        case loadError(BaseError)
    }
    
    @Dependency(\.movieWorker) var worker
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            state.isLoading = true
            return .run { send in
                let result = await worker.fetchMovies(page: 1)
                switch result {
                case .success(let movieResult):
                    await send(.moviesLoaded(movieResult?.results ?? []))
                case .failure(let error):
                    await send(.loadError(error))
                }
            }
        case let .moviesLoaded(movies):
            state.isLoading = false
            if let movies = movies {
                state.movies.append(contentsOf: movies)
            }
            return .none
        case let .loadError(message):
            state.isLoading = false
            state.errorMessage = message.errorMessage
            return .none
        }
    }
}
