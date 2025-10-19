//
//  CounterView.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 18/10/25.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    let store: StoreOf<CounterReducer>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                Text("Count: \(viewStore.count)")
                    .padding()

                Button("Increment") {
                    viewStore.send(.increment)
                }
                
                Button("Decrement") {
                    viewStore.send(.decrement)
                }
            }
        }
    }
}

#Preview {
    CounterView(
        store: Store(
            initialState: CounterReducer.State(),
            reducer: { CounterReducer() }
        )
    )
}
