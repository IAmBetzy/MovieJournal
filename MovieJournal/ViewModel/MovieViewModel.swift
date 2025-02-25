//
//  MovieViewModel.swift
//  MovieJournal
//
//  Created by Claudia Moca on 25/02/25.
//

import Foundation
import UIKit

class MovieViewModel: ObservableObject {
    @Published public var movies: [Movie] = [
        Movie(title: "Aladdin", genre: "Aladdin", year: "fantasy", description: "1992", imageName: "aladdin"),
        Movie(title: "Tierra de osos", genre: "adventure", year: "1999", description: "Un humano se convierte en un oso", imageName: "Brother bear" ),
        Movie(title: "The Lion King", genre: "adventure", year: "1995", description: "noooo mufasa", imageName: "The Lion King" ),
        Movie(title: "La la land", genre: "romance", year: "2019", description: "Bailarines en LA", imageName: "La la land" )
    ]
}
