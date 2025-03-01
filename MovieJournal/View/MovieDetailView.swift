//
//  MovieDetailView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

import SwiftUI

//DetailView de cada pelicula en la que se muestran los datos
struct MovieDetailView: View {
    var movie: Movie
    
    @ObservedObject var reviewViewModel: ReviewViewModel
    @ObservedObject var movieViewModel: MovieViewModel
    @State private var watched = false
    
    var body: some View {
        ScrollView {
            //Se muestra la portada de la pelicula
            Image(uiImage: UIImage(named: movie.imageName) ?? UIImage(systemName: "photo")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 250, alignment: .center)
                .padding(.top, 30.0)
                
            //se muestra el titulo, genre y año de la pelicula
                VStack(alignment: .leading, spacing: 20) {
                    Text(movie.title)
                        .font(.title)
                        .bold()
                        .padding(.top)
                    HStack {
                        Text("Genre: \(movie.genre)")
                        Spacer()
                        Text("Year: \(movie.year)")
                    }
                    .padding()
                    .font(.subheadline)
                    
                    //boton para marcar si la pelicula ya se vio o no
                    HStack{
                        Button(action: {
                            watched.toggle()
                        }) {
                            HStack {
                                Image(systemName: watched ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .foregroundColor(watched ? .green : .red)
                                Text(watched ? "Watched" : "Not Watched")
                            }
                        }
                        Spacer()
                        //NavigationLink para agregar una reseña de la pelicula en cuestion
                        NavigationLink(destination: AddReviewView(reviewViewModel: ReviewViewModel(), movieViewModel: MovieViewModel(), selectedMovie: movie)) {
                            Text("Agrega una reseña")
                        }
                    }
                }
                .padding()
                .navigationTitle("Movie Details")
                //descripcion de la pelicula
            Text(movie.description)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .foregroundColor(.gray)
            }
        }
    }

#Preview {
    MovieDetailView(movie: Movie(title: "titulo", genre: "genre", year: "1999", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", watched: false, imageName: "photo"), reviewViewModel: ReviewViewModel(), movieViewModel: MovieViewModel())
}
