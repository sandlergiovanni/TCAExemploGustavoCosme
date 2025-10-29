//
//  DetailState.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 28/10/25.
//

struct DetailState: Equatable {
    var movie: Movie
    var details: Movie?
    var isLoading = false
    var errorMessage: String?
}
