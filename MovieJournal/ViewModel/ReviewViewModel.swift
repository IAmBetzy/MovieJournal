//
//  ReviewViewModel.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 24/02/25.
//

import Foundation
import UIKit
import SwiftUICore
import CoreData

//ViewModel de las reseñas. 2 reseñas guardads y las funciones correspondientes
class ReviewViewModel: ObservableObject {
    @Published var movieViewModel = MovieViewModel()
    @Published public var reviews: [Review] = []
    let context = PersistenceController.shared.container.viewContext
    
    init() {
        reviews.append(Review(movie: movieViewModel.movies[0], review: "Muy chida", selfie: UIImage(named: "selfie1"), date: Date(),  rating: "★★★", latitude: 32.5149, longitude: -117.0382 ))
        reviews.append(Review(movie: movieViewModel.movies[1], review: "Me goofy", selfie: UIImage(named: "selfie2"), date: Date(), rating: "★★", latitude: 32.5027, longitude: -116.9975 ))
    }
    
    //Funcion para agregar una nueva reseña a la  lista de rese;as
//    func addReview(movie: Movie, review: String, selfie: UIImage?, date: Date, rating: String, latitude: Double?, longitude: Double?){
//        let newReview = Review(movie: movie, review: review, selfie: selfie, date: date, rating: rating, latitude: latitude, longitude: longitude)
//        reviews.append(newReview)
//    }
    func addReview(movie: Movie, review: String, selfie: UIImage?, date: Date, rating: String, latitude: Double?, longitude: Double?, context: NSManagedObjectContext) {
        let reviewEntity = ReviewEntity(context: context)
        reviewEntity.id = UUID()
        reviewEntity.movieId = movie.id
        reviewEntity.review = review
        reviewEntity.selfie = selfie
        reviewEntity.date = date
        reviewEntity.rating = rating
        reviewEntity.rating = rating
        reviewEntity.latitude = latitude!
        reviewEntity.longitude = longitude!
        
        do {
                try context.save()
            } catch {
                print("Error guardando review: \(error)")
            }
    }
    
    func loadReviews(from catalog: [Movie]) {
            reviews = fetchReviews(context: context, movies: catalog)
        }
    
    private func fetchReviews(context: NSManagedObjectContext, movies: [Movie]) -> [Review] {
            let request: NSFetchRequest<ReviewEntity> = ReviewEntity.fetchRequest()
            
            do {
                let reviewEntities = try context.fetch(request)
                return reviewEntities.compactMap { entity in
                    guard let movie = movies.first(where: { $0.id == entity.movieId }) else {
                        return nil
                    }

                    return Review(
                        id: entity.id ?? UUID(),
                        text: entity.text ?? "",
                        rating: Int(entity.rating),
                        movie: movie
                    )
                }
            } catch {
                print("Error cargando reviews: \(error)")
                return []
            }
        }
    
    //funcion para eliminar una rese;a de la lista de reseñas
    func deleteReview(at offset: IndexSet) {
        reviews.remove(atOffsets: offset)
    }
}
