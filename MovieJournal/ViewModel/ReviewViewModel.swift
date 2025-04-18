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
    @Published public var reviews: [ReviewEntity] = PersistenceController.shared.reviews()
    //let context = PersistenceController.shared.container.viewContext
    
    //funcion para eliminar una rese;a de la lista de reseñas
    func deleteReview(at offset: IndexSet) {
        reviews.remove(atOffsets: offset)
    }
}
