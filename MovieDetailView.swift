//
//  MovieDetailView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

import SwiftUI

struct MovieDetailView: View {
    var movie: Movies

    @State private var selectedImage: UIImage?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(movie.title)
                    .font(.title)
                    .bold()
                
                HStack {
                    Text("Genre: \(movie.genre)")
                    Spacer()
                    Text("Year: \(movie.year)")
                }
                .font(.subheadline)
                
                Image(uiImage: selectedImage ?? UIImage(named: movie.imageName ?? "placeholder") ?? UIImage(systemName: "photo")!)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
                    .onTapGesture {
                        self.selectImage()
                    }
                
                Toggle(isOn: .constant(movie.watched)) {
                    Text(movie.watched ? "Watched" : "Not Watched")
                }
                .disabled(true)
            }
            .padding()
            .navigationTitle("Movie Details")
        }
    }
    
    func selectImage() {
        // Función para seleccionar una imagen de la galería o tomar una nueva foto.
        // Esto es solo un placeholder, necesitarías implementar la selección de imagen aquí.
    }
}
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMovie = Movies(
            title: "Shrek",
            genre: "Animated/Sci-Fi",
            year: 2001,
            watched: false,
            imageName: "shrek"
        )
        
        MovieDetailView(movie: sampleMovie)
            .previewDevice("iPhone 12") 
    }
}
