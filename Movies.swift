//
//  MovieDetailsView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

import Foundation

struct Movies: Identifiable {
    let id = UUID()
    var title: String
    var genre: String
    var year: Int
    var watched: Bool
    var imageName: String?
}
