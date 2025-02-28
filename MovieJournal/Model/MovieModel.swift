//
//  MovieDetailsView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

import Foundation
import UIKit

struct Movie: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var genre: String
    var year: String
    var description: String  //I added
    var watched: Bool = false
    var imageName: String
    
    //funciones para poder usar el picker, creo que era mas facil con un search bar idk
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    static func == (lhs: Movie, rhs: Movie) -> Bool {
            return lhs.id == rhs.id
        }
}
