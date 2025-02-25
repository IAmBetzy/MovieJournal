//
//  MovieRowView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

import SwiftUI

struct MovieRowView: View {
    var movie : Movie
    
    var body: some View {
        HStack {
            //Display image
            Image(movie.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 70, alignment: .center)
            //cambiar para que la foto la saque de la base
                .font(.largeTitle)
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
