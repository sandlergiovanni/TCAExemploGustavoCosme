//
//  HomeState.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 26/10/25.
//

import ComposableArchitecture

@ObservableState
struct HomeState: Equatable {
    var page: Int = 0
    var movies: [Movie] = []
    var errorMessage: String? = nil
    var isLoading: Bool = false
    var hasMorePage: Bool = true
    var selectedMovie: Movie? = nil
}
