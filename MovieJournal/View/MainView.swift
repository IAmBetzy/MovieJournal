//
//  MainView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

import SwiftUI
import UIKit

//AGREGAR BARRA DE BUSQUEDA
//Que se vean los puros posters

struct MainView: View {
    @ObservedObject var movieViewModel: MovieViewModel
    
    var body: some View {
        NavigationView {
            List{
                ForEach(movieViewModel.movies) {movie in NavigationLink(destination: MovieDetailView(movie: movie, reviewViewModel: ReviewViewModel(), movieViewModel: MovieViewModel())) {
                    MovieRowView(movie: movie)
                        .padding(.leading, -4.0)
                        .padding(.vertical, 3.0)
                }
                }
            }
            .navigationTitle(Text("Movies"))
        }
    }
}

#Preview {
    MainView(movieViewModel: MovieViewModel())
}
