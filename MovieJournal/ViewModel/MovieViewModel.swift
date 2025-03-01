//
//  MovieViewModel.swift
//  MovieJournal
//
//  Created by Claudia Moca on 25/02/25.
//

import Foundation
import UIKit

//ViewModel de las peliculas. La pequeña base de datos con la que trabajamos para el proyecto
class MovieViewModel: ObservableObject {
    @Published public var movies: [Movie] = [
        Movie(title: "Aladdin", genre: "fantasy", year: "1992", description: "Un joven encuentra una lámpara mágica.", watched: true, imageName: "aladdin"),
        Movie(title: "Tierra de osos", genre: "adventure", year: "2003", description: "Un humano se convierte en un oso.", watched: true, imageName: "brother_bear"),
            Movie(title: "The Lion King", genre: "adventure", year: "1994", description: "Un joven león busca su destino tras la muerte de su padre.", imageName: "the_lion_king"),
            Movie(title: "La La Land", genre: "romance", year: "2016", description: "Un pianista y una actriz persiguen sus sueños en Los Ángeles.", imageName: "la_la_land"),
            Movie(title: "Inception", genre: "sci-fi", year: "2010", description: "Un ladrón entra en los sueños de las personas para robar secretos.", imageName: "inception"),
            Movie(title: "Interstellar", genre: "sci-fi", year: "2014", description: "Astronautas viajan a través de un agujero de gusano en busca de un nuevo hogar.", imageName: "interstellar"),
            Movie(title: "Titanic", genre: "romance", year: "1997", description: "Una historia de amor en el fatídico viaje del Titanic.", imageName: "titanic"),
            Movie(title: "The Matrix", genre: "sci-fi", year: "1999", description: "Un hacker descubre la verdadera naturaleza de su realidad.", imageName: "the_matrix"),
            Movie(title: "The Godfather", genre: "crime", year: "1972", description: "La historia de una familia mafiosa en Nueva York.", imageName: "the_godfather"),
            Movie(title: "Forrest Gump", genre: "drama", year: "1994", description: "Un hombre con un bajo coeficiente intelectual influye en la historia de EE.UU.", imageName: "forrest_gump"),
            Movie(title: "The Dark Knight", genre: "action", year: "2008", description: "Batman enfrenta al Joker en Gotham.", imageName: "the_dark_knight"),
            Movie(title: "Avatar", genre: "sci-fi", year: "2009", description: "Un exmarine explora el mundo de Pandora.", imageName: "avatar"),
            Movie(title: "Gladiator", genre: "action", year: "2000", description: "Un general romano busca venganza tras la traición del emperador.", imageName: "gladiator"),
            Movie(title: "Pulp Fiction", genre: "crime", year: "1994", description: "Historias entrelazadas de crimen y redención en Los Ángeles.", imageName: "pulp_fiction"),
            Movie(title: "Finding Nemo", genre: "animation", year: "2003", description: "Un pez payaso busca a su hijo perdido en el océano.", imageName: "finding_nemo"),
            Movie(title: "The Shawshank Redemption", genre: "drama", year: "1994", description: "Un banquero condenado injustamente planea escapar de la cárcel.", imageName: "the_shawshank_redemption"),
            Movie(title: "Shrek", genre: "animation", year: "2001", description: "Un ogro debe rescatar a una princesa para recuperar su pantano.", imageName: "shrek"),
            Movie(title: "Toy Story", genre: "animation", year: "1995", description: "Los juguetes cobran vida cuando los humanos no los ven.", imageName: "toy_story"),
            Movie(title: "Up", genre: "animation", year: "2009", description: "Un anciano y un niño exploran Sudamérica en una casa con globos.", imageName: "up"),
            Movie(title: "The Grand Budapest Hotel", genre: "comedy", year: "2014", description: "Las aventuras de un conserje en un hotel europeo de lujo.", imageName: "the_grand_budapest_hotel")
    ]
}
