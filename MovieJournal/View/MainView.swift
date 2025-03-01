//
//  MainView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

import SwiftUI
import UIKit

//Pantalla principal, se muestra una lista de todas las peliculas disponibles. Cada fila es un navigation link que al picarle te muestra MovieDetailView

struct MainView: View {
    @ObservedObject var movieViewModel: MovieViewModel
    
    var body: some View {
        NavigationView {
            List{
                //Lista de peliculas
                ForEach(movieViewModel.movies) {movie in NavigationLink(destination: MovieDetailView(movie: movie, reviewViewModel: ReviewViewModel(), movieViewModel: MovieViewModel())) {
                    //Vista de cada boton
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
