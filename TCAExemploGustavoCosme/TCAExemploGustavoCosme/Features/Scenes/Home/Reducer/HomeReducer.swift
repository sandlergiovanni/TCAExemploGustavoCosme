//
//  HomeReducer.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 19/10/25.
//

import ComposableArchitecture

@Reducer
struct HomeReducer {
    @Dependency(\.movieWorker) var worker
    
    func reduce(into state: inout HomeState, action: HomeAction) -> Effect<HomeAction> {
        switch action {
        case .onAppear:
            if state.isLoading {
                return .none
            }
            state.isLoading = true
            return loadDataFrom(page: 1)
        case let .loadNextPageIfNeeded(currentMovie):
            guard !state.isLoading, state.hasMorePage else {
                return .none
            }
            guard let lastId = state.movies.last?.id,
                  lastId == currentMovie.id else {
                return .none
            }
            let nextPage = state.page + 1
            return loadDataFrom(page: nextPage)
        case let .moviesLoaded(movies):
            state.isLoading = false
            if let movies = movies, movies.count > 0 {
                state.movies.append(contentsOf: movies)
                state.page += 1
            } else {
                state.hasMorePage = false
            }
            return .none
        case let .loadError(message):
            state.isLoading = false
            state.errorMessage = message.errorMessage
            return .none
        case let .didSelectMovie(movie):
            state.selectedMovie = movie
            return .none
        }
    }

    private func loadDataFrom(page: Int) -> Effect<HomeAction> {
        .run { send in
            let result = await worker.fetchMovies(page: page)
            switch result {
            case .success(let movieResult):
                await send(.moviesLoaded(movieResult?.results ?? []))
            case .failure(let error):
                await send(.loadError(error))
            }
        }
    }
}
