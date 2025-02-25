//
//  ReviewModel.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

import Foundation
import UIKit

struct Review: Identifiable {
    let id = UUID()
    var movie: Movie //con movierow view que acceda a la pelicula
    var review: String
    var selfieName: String?
    var date: Date
    var rating: String //like emojis in moodtracker app
    var latitude: Double?
    var longitude: Double?
}
