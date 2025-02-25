//
//  ReviewViewModel.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 24/02/25.
//

import Foundation
import UIKit

class ReviewViewModel: ObservableObject {
    @Published public var reviews: [Review] = [
        //conectar las peliculas correctamente
        Review(movie: Movie(title: "Aladdin", genre: "fantasy", year: "1992", description: "aladdin y su lampara magica", imageName: "aladdin"), review: "Muy chida", date: Date(), rating: "★★★" ),
        Review(movie: Movie(title: "Tierra de osos", genre: "fantasy", year: "1999", description: "Un humano se convierte en un oso", imageName: "Brother bear"), review: "Me goofy", date: Date(), rating: "★★" )
    ]
    
    func addReview(movie: Movie, review: String, selfie: UIImage?, date: Date, rating: String, latitude: Double?, longitude: Double?){
        let newReview = Review(movie: movie, review: review, date: date, rating: rating, latitude: latitude, longitude: longitude)
        reviews.append(newReview)
    }
    
    func deleteReview(at offset: IndexSet) {
        reviews.remove(atOffsets: offset)
    }
}
