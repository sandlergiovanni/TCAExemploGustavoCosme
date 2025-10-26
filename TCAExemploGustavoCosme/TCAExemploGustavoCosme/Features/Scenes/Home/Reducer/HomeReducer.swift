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
        var page: Int = 0
        var movies: [Movie] = []
        var errorMessage: String? = nil
        var isLoading: Bool = false
        var lastId: Int = 0
    }
    
    enum Action: Equatable {
        case onAppear
        case moviesLoaded([Movie]?)
        case loadError(BaseError)
        case loadNextPage
    }
    
    @Dependency(\.movieWorker) var worker
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            if state.isLoading {
                return .none
            }
            state.isLoading = true
            let nextPage = state.page + 1
            return .run { send in
                let result = await worker.fetchMovies(page: nextPage)
                switch result {
                case .success(let movieResult):
                    await send(.moviesLoaded(movieResult?.results ?? []))
                case .failure(let error):
                    await send(.loadError(error))
                }
            }
        case .loadNextPage:
            if state.isLoading {
                return .none
            }
            return .send(.onAppear)
        case let .moviesLoaded(movies):
            state.isLoading = false
            if let movies = movies, movies.count > 0 {
                state.movies.append(contentsOf: movies)
                state.page += 1
            }
            state.lastId = movies?.last?.id ?? 0
            return .none
        case let .loadError(message):
            state.isLoading = false
            state.errorMessage = message.errorMessage
            return .none
        }
    }
}
