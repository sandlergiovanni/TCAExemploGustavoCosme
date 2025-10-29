//
//  MovieDetailView.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 28/10/25.
//

import SwiftUI
import ComposableArchitecture

struct MovieDetailView: View {
    let store: StoreOf<DetailReducer>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if viewStore.isLoading {
                        ProgressView("Loading...")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 40)
                    } else {
                        if let error = viewStore.errorMessage {
                            VStack(spacing: 12) {
                                Text("Erro ao carregar detalhes:")
                                    .font(.headline)
                                Text(error)
                                    .foregroundColor(.red)
                                Button("Tentar novamente") {
                                    viewStore.send(.onAppear)
                                }
                                .buttonStyle(.borderedProminent)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 40)
                        } else {
                            if let details = viewStore.details {
                                VStack(alignment: .leading, spacing: 16) {
                                    PosterImage(url: details.posterUrlPath ?? "")
                                        .frame(maxWidth: .infinity)
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(12)
                                    
                                    Text(details.title)
                                        .font(.title)
                                        .bold()
                                        .padding(.bottom, 4)
                                    
                                    if let rating = details.voteAverage {
                                        HStack {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                            Text(String(format: "%.1f", rating))
                                                .font(.subheadline)
                                        }
                                    }
                                    
                                    Divider()
                                    
                                    Text(details.overview ?? "Sem descrição disponível.")
                                        .font(.body)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
            .navigationTitle(viewStore.movie.title)
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

#Preview {
    let movie = Movie(id: 1,
                      title: "Titulo teste",
                      overview: "Sinopse teste",
                      posterPath: "url.com",
                      backdropPath: "url.com",
                      voteAverage: 1.0,
                      voteCount: 1)

    MovieDetailView(
        store: Store(
            initialState: DetailState(movie: movie),
            reducer: { DetailReducer() }
        )
    )
}
