//
//  ReviewRowView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

import SwiftUI

//View de la fila de las reseñas que se encuentra en ReviewsView
struct ReviewRowView: View {
    var review: ReviewEntity
    @ObservedObject var movieViewModel = MovieViewModel()
    
    var body: some View {
        //buscar entre peliculas con id igual
        let movie = movieViewModel.movies.first(where: { $0.intId == review.movieId })
//        guard let movie = movieViewModel.movies.first(where: { $0.id == review.movieId }) else {
//            Text("No se encontro la pelicula")
//        }
        
        HStack {
            //Muestra la imagen de la pelicula
            Image(movie?.imageName ?? "photo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 70, alignment: .center)
            //Muestra el titulo, el puntaje y la fecha en la que se realizo la reseña
            VStack(alignment: .leading) {
                Text(movie?.title ?? "Titulo")
                    .font(.headline)
                Text(review.rating ?? "★★")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(review.date?.formatted(date: .numeric, time: .omitted) ?? Date().formatted(date: .numeric, time: .omitted))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
            }
            Spacer()
        }
    }
}

//#Preview {
//    ReviewRowView(review: Review(movie: Movie(title: "tituloo", genre: "genero", year: "año", description: "descripcion", imageName: "aladdin"), review: "me encanto", selfie: UIImage(systemName: "photo")!, date: Date() , rating: "5 estrellas") )
//}
