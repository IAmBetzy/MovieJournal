//
//  ReviewRowView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

import SwiftUI

struct ReviewRowView: View {
    var review:Review
    
    var body: some View {
        HStack {
            //Display image
            Image(systemName: "photo") //que obtenga la foto desde la pelicula enlazada (cambiar movie row primero)
                .font(.largeTitle)
            VStack(alignment: .leading) {
                Text(review.movie.title)
                    .font(.headline)
                Text(review.rating)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(review.date.formatted(date: .numeric, time: .omitted))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
            }
            Spacer()
        }
    }
}

#Preview {
    ReviewRowView(review: Review(movie: Movie(title: "tituloo", genre: "genero", year: "año", description: "descripcion"), review: "me encanto", date: Date() , rating: "5 estrellas") )
}
