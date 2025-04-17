//
//  ActorViewModel.swift
//  MovieJournal
//
//  Created by Claudia Moca on 16/04/25.
//

import Foundation
import UIKit

//ViewModel de los actores. La pequeña base de datos con la que trabajamos para el proyecto
class ActorViewModel: ObservableObject {
    @Published public var actors: [Actor] = [
        Actor(name: "Angelina Jolie", wikiLink: URL(string: "https://en.wikipedia.org/wiki/Angelina_Jolie"), imageName: "AngelinaJolie"),
        Actor(name: "Brad Pitt", wikiLink: URL(string: "https://en.wikipedia.org/wiki/Brad_Pitt"), imageName: "BradPitt"),
        Actor(name: "Denzel Washington", wikiLink: URL(string: "https://en.wikipedia.org/wiki/Denzel_Washington"), imageName: "DenzelWashington"),
        Actor(name: "Hugh Jackman", wikiLink: URL(string: "https://en.wikipedia.org/wiki/Hugh_Jackman"), imageName: "HughJackman"),
        Actor(name: "Jennifer Lawrence", wikiLink: URL(string: "https://en.wikipedia.org/wiki/Jennifer_Lawrence"), imageName: "JenniferLawrence"),
        Actor(name: "Johnny Depp", wikiLink: URL(string: "https://en.wikipedia.org/wiki/Johnny_Depp"), imageName: "JohnnyDepp"),
        Actor(name: "Kate Winslet", wikiLink: URL(string: "https://en.wikipedia.org/wiki/Kate_Winslet"), imageName: "KateWinslet"),
        Actor(name: "Leonardo DiCaprio", wikiLink: URL(string: "https://en.wikipedia.org/wiki/Leonardo_DiCaprio"), imageName: "LeonardoDiCaprio"),
        Actor(name: "Megan Fox", wikiLink: URL(string: "https://en.wikipedia.org/wiki/Megan_Fox"), imageName: "MeganFox"),
        Actor(name: "Natalie Portman", wikiLink: URL(string: "https://en.wikipedia.org/wiki/Natalie_Portman"), imageName: "NataliePortman"),
        Actor(name: "Nicole Kidman", wikiLink: URL(string: "https://en.wikipedia.org/wiki/Nicole_Kidman"), imageName: "NicoleKidman"),
        Actor(name: "Robert Downey Jr", wikiLink: URL(string: "https://en.wikipedia.org/wiki/Robert_Downey_Jr."), imageName: "RobertDowneyJr"),
        Actor(name: "Sandra Bullock", wikiLink: URL(string: "https://en.wikipedia.org/wiki/Sandra_Bullock"), imageName: "SandraBullock"),
        Actor(name: "Scarlett Johansson", wikiLink: URL(string: "https://en.wikipedia.org/wiki/Scarlett_Johansson"), imageName: "ScarlettJohansson"),
        Actor(name: "Tom Cruise", wikiLink: URL(string: "https://en.wikipedia.org/wiki/Tom_Cruise"), imageName: "TomCruise"),
        Actor(name: "Tom Hanks", wikiLink: URL(string: "https://en.wikipedia.org/wiki/Tom_Hanks"), imageName: "TomHanks"),
        Actor(name: "Will Smith", wikiLink: URL(string: "https://en.wikipedia.org/wiki/Will_Smith"), imageName: "WillSmith")
    ]
}
