//
//  MovieRowView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

import SwiftUI

//Vista row de la pelicula para mostrar en la pantalla principal como forma de lista
struct MovieRowView: View {
    var movie : Movie
    
    var body: some View {
        HStack {
            //Muestra la imagen
            Image(movie.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 70, alignment: .center)
                .font(.largeTitle)
            //Muestra el titulo y el año
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.year)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
            }
            Spacer()
        }
    }
}

#Preview{
    MovieRowView(movie: Movie(title: "tituloo", genre: "genero", year: "año", description: "descripcion", imageName: "aladdin"))
}
