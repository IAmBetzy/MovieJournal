//
//  PersistenceController.swift
//  MovieJournal
//
//  Created by Claudia Moca on 17/04/25.
//

import CoreData
import UIKit

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unresolved error: \(error)")
            }
        }
    }
    
    func review(movieId: UUID, review: String, selfie: UIImage?, date: Date, rating: String, latitude: Double?, longitude: Double?) -> ReviewEntity {
        let revie = ReviewEntity(context: PersistenceController.shared.container.viewContext)
        revie.review = review
        revie.selfie = selfie?.jpegData(compressionQuality: 0.8)
        revie.date = date
        revie.rating = rating
        if let latitude = latitude, let longitude = longitude {
            revie.latitude = latitude
            revie.longitude = longitude
        }
        revie.movieId = movieId
        return revie
        
    }
    
    func reviews() -> [ReviewEntity] {
        let request: NSFetchRequest<ReviewEntity> = ReviewEntity.fetchRequest()
        
        var fetchedReviews: [ReviewEntity] = []
        
        do {
            fetchedReviews = try PersistenceController.shared.container.viewContext.fetch(request)
        } catch {
            print("Error fetching reviews")
        }
        
        return fetchedReviews
    }
    
//    func addReview(movie: Movie, review: String, selfie: UIImage?, date: Date, rating: String, latitude: Double?, longitude: Double?, context: NSManagedObjectContext) {
//        let reviewEntity = ReviewEntity(context: context)
//        reviewEntity.id = UUID()
//        reviewEntity.movieId = movie.id
//        reviewEntity.review = review
//        //to convert to binary data for entity
//        reviewEntity.selfie = selfie!.jpegData(compressionQuality: 0.8)
//        reviewEntity.date = date
//        reviewEntity.rating = rating
//        if let latitude = latitude, let longitude = longitude {
//            reviewEntity.latitude = latitude
//            reviewEntity.longitude = longitude
//        }
//        
//        do {
//                try context.save()
//            } catch {
//                print("Error guardando review: \(error)")
//            }
//    }
    
    func saveContext () {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save () }
            catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
} 
