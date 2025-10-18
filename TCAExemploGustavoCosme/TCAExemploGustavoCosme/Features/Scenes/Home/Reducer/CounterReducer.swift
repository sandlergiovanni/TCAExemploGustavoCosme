//
//  CounterReducer.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 18/10/25.
//

import ComposableArchitecture

@Reducer
struct CounterReducer {
    @ObservableState
    struct State: Equatable {
        var count = 0
    }

    enum Action: Equatable {
        case increment
        case decrement
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .increment:
            state.count += 1
            return .none
        case .decrement:
            state.count -= 1
            return .none
        }
    }
}
