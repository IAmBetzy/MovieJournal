//
//  MovieDetailsView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

import SwiftUI

struct MoviesView: View {
    @State private var movies: [Movies] = [
        Movies(title: "Shrek", genre: "Animated/Sci-Fi", year: 2001, watched: false, imageName: "shrek"),
        Movies(title: "Interstellar", genre: "Sci-Fi", year: 2014, watched: true, imageName: "interstellar")
    ]

    var body: some View {
        NavigationStack {
            List(movies) { movie in
                NavigationLink(destination: MoviesView()) {
                    HStack {
                        Image(movie.imageName ?? "placeholder")
                            .resizable()
                            .frame(width: 50, height: 70)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                            Text(movie.genre)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Image(systemName: movie.watched ? "checkmark.circle.fill" : "clock.fill")
                            .foregroundColor(movie.watched ? .green : .orange)
                    }
                }
            }
            .navigationTitle("Que quieres ver?")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
