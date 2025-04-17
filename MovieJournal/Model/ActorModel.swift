//
//  ActorModel.swift
//  MovieJournal
//
//  Created by Claudia Moca on 16/04/25.
//

import Foundation
import UIKit

//Actor struct
//Los actores cuentan con los siguientes atributos
struct Actor: Identifiable {
    let id = UUID()
    let name: String    //labels del modelo
    let wikiLink: URL?
    let imageName: String
}
