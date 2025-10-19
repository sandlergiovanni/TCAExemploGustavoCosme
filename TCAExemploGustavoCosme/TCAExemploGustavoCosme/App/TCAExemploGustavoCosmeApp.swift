//
//  TCAExemploGustavoCosmeApp.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 18/10/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCAExemploGustavoCosmeApp: App {
    var body: some Scene {
        WindowGroup {
            CounterView(store: Store(
                initialState: CounterReducer.State(),
                reducer: { CounterReducer() }
            ))
        }
    }
}
