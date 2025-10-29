//
//  DetailReducer.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 28/10/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct DetailReducer {
    @Dependency(\.movieDetailsWorker) var worker

    func reduce(into state: inout DetailState, action: DetailAction) -> Effect<DetailAction> {
        switch action {
        case .onAppear:
            if state.isLoading {
                return .none
            }
            state.isLoading = true
            return loadDetails(of: state.movie.id)
        case let .detailsLoaded(details):
            state.isLoading = false
            state.details = details
            return .none
        case let .loadError(message):
            state.isLoading = false
            state.errorMessage = message.errorMessage
            return .none
        }
    }

    private func loadDetails(of id: Int) -> Effect<DetailAction> {
        .run { send in
            let result = await worker.fetchMovieDetails(of: id)
            switch result {
            case .success(let movieResult):
                guard let validResult = movieResult else {
                    await send(.loadError(BaseError(errorMessage: "Movie not found.")))
                    return
                }
                await send(.detailsLoaded(validResult))
            case .failure(let error):
                await send(.loadError(error))
            }
        }
    }
}
