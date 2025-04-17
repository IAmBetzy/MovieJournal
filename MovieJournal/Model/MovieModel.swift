//
//  MovieDetailsView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

import Foundation
import UIKit

//Movie struct
//Las peliculas cuantan con los siguientes atributos, se utilizo una estructura hashable para
//poder usar las peliculas dentro del picker en el form de AddReviewView
struct Movie: Codable, Identifiable, Hashable {
    let id = UUID()
    var title: String
    var genre: String
    var year: String
    var description: String
    var watched: Bool = false
    var imageName: String
    
    //funciones para poder usar el picker
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    static func == (lhs: Movie, rhs: Movie) -> Bool {
            return lhs.id == rhs.id
        }
}
