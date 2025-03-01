//
//  ReviewViewModel.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 24/02/25.
//

import Foundation
import UIKit
import SwiftUICore

//ViewModel de las reseñas. 2 reseñas guardads y las funciones correspondientes
class ReviewViewModel: ObservableObject {
    @Published var movieViewModel = MovieViewModel()
    @Published public var reviews: [Review] = []

    init() {
        reviews.append(Review(movie: movieViewModel.movies[0], review: "Muy chida", selfie: UIImage(named: "selfie1"), date: Date(),  rating: "★★★", latitude: 32.5149, longitude: -117.0382 ))
        reviews.append(Review(movie: movieViewModel.movies[1], review: "Me goofy", selfie: UIImage(named: "selfie2"), date: Date(), rating: "★★", latitude: 32.5027, longitude: -116.9975 ))
    }
    
    //Funcion para agregar una nueva reseña a la  lista de rese;as
    func addReview(movie: Movie, review: String, selfie: UIImage?, date: Date, rating: String, latitude: Double?, longitude: Double?){
        let newReview = Review(movie: movie, review: review, selfie: selfie, date: date, rating: rating, latitude: latitude, longitude: longitude)
        reviews.append(newReview)
    }
    
    //funcion para eliminar una rese;a de la lista de reseñas
    func deleteReview(at offset: IndexSet) {
        reviews.remove(atOffsets: offset)
    }
}
