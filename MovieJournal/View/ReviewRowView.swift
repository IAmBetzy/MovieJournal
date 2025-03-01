//
//  ReviewRowView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

import SwiftUI

//View de la fila de las reseñas que se encuentra en ReviewsView
struct ReviewRowView: View {
    var review:Review
    
    var body: some View {
        HStack {
            //Muestra la imagen de la pelicula
            Image(review.movie.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 70, alignment: .center)
            //Muestra el titulo, el puntaje y la fecha en la que se realizo la reseña
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
    ReviewRowView(review: Review(movie: Movie(title: "tituloo", genre: "genero", year: "año", description: "descripcion", imageName: "aladdin"), review: "me encanto", selfie: UIImage(systemName: "photo")!, date: Date() , rating: "5 estrellas") )
}
