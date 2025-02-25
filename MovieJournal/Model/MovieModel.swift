//
//  MovieDetailsView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

import Foundation
import UIKit

struct Movie: Identifiable {
    let id = UUID()
    var title: String
    var genre: String
    var year: String
    var description: String  //I added
    var watched: Bool = false
    var imageName: String?
}
