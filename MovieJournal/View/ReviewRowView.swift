//
//  ReviewRowView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

import SwiftUI
//agregar location

struct ReviewRowView: View {
    var review:Review
    
    var body: some View {
        HStack {
            Image(review.movie.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 70, alignment: .center)//que obtenga la foto desde la pelicula enlazada (cambiar movie row primero)
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
