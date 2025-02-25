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
struct MainView: View {
    //cambiar para que acceda a los datos desde Movies
    let movies: [Movie] = [
        Movie(title: "Aladdin", genre: "fantasy", year: "1992", description: "aladdin y su lampara magica"),
        Movie(title: "Tierra de osos", genre: "adventure", year: "1999", description: "Un humano se convierte en un oso"),
        Movie(title: "La la land", genre: "romance", year: "2019", description: "Bailarines en LA")
    ]
    
    var body: some View {
        NavigationView {
            List{
                //first MovieRowView must be changed for MovieDetailView
                ForEach(movies) {movie in NavigationLink(destination: MovieRowView(movie: movie)) {
                    MovieRowView(movie: movie)
                    
                }
                }
            }
            .navigationTitle(Text("Movies"))
        }
    }
}

#Preview {
    MainView()
}
