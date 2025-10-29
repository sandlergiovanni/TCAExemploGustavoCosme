//
//  HomeAction.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 26/10/25.
//

import ComposableArchitecture

enum HomeAction: Equatable {
    case onAppear
    case moviesLoaded([Movie]?)
    case loadError(BaseError)
    case loadNextPageIfNeeded(currentMovie: Movie)
    case didSelectMovie(Movie)
}
