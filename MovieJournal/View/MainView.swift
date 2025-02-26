//
//  MainView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

import SwiftUI
import UIKit

//FALTA QUE AL DAR CLICK ENTRE A LA VISTA DE DETALLES
//AGREGAR BARRA DE BUSQUEDA
//Que se vean los puros posters

struct MainView: View {
    @ObservedObject var movieViewModel: MovieViewModel
    //cambiar para que acceda a los datos desde Movies
    
    var body: some View {
        NavigationView {
            List{
                //first MovieRowView must be changed for MovieDetailView
                ForEach(movieViewModel.movies) {movie in NavigationLink(destination: MovieRowView(movie: movie)) {
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
