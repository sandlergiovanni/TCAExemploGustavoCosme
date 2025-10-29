//
//  DetailAction.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 28/10/25.
//

enum DetailAction: Equatable {
    case onAppear
    case detailsLoaded(Movie)
    case loadError(BaseError)
}
