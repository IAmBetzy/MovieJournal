//
//  ReviewModel.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//
import Foundation
import UIKit

//Review struct
//Las reviews cuantan con los siguientes atributos
struct Review: Identifiable {
    let id = UUID()
    var movie: Movie            //Asociada a una pelicula
    var review: String
    var selfie: UIImage?
    var date: Date
    var rating: String 
    var latitude: Double?
    var longitude: Double?
}
