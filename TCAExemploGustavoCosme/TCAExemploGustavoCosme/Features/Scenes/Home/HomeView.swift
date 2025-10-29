//
//  HomeView.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 19/10/25.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    var store: StoreOf<HomeReducer>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                if viewStore.isLoading && viewStore.movies.isEmpty {
                    ProgressView("Loading...").progressViewStyle(CircularProgressViewStyle())
                } else {
                    if let error = viewStore.errorMessage {
                        ErrorPanel(errorMessage: error) { viewStore.send(.onAppear) }
                    } else {
                        List(viewStore.movies, id:\.id) { movie in
                            Button {
                                viewStore.send(.didSelectMovie(movie))
                            } label: {
                                CardLink(movie: movie).onAppear() {
                                    viewStore.send(.loadNextPageIfNeeded(currentMovie: movie))
                                }
                            }
                            .buttonStyle(.plain)
                        }
                        .overlay(alignment: .bottom) {
                            if viewStore.isLoading {
                                ProgressView().padding()
                            }
                        }
                        .navigationTitle("Filmes Populares")
                        .onAppear {
                            viewStore.send(.onAppear)
                        }
                    }
                }
            }
        }
    }
}

fileprivate struct ErrorPanel: View {
    var errorMessage: String
    var tryAgaing: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Ocorreu um erro:")
                .font(.headline)
            
            Text(errorMessage)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            Button("Tentar novamente") {
                tryAgaing()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

fileprivate struct CardLink: View {
    var movie: Movie

    var body: some View {
        HStack(spacing: 16) {
            PosterImage(url: movie.posterUrlPath ?? "")
            
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title).font(.headline)
                
                Text(movie.overview ?? "-")
                    .font(.subheadline)
                    .lineLimit(3)
            }
        }
        .padding(.vertical, 8)
    }
}



#Preview {
    HomeView(
        store: Store(
            initialState: HomeState(),
            reducer: { HomeReducer() }
        )
    )
}
