//
//  AddReviewView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 24/02/25.
//

import SwiftUI

struct AddReviewView: View {
    @Environment(\.presentationMode) var presentationMode
 
    @State private var movie = Movie(title: "", genre: "" , year: "", description: "", watched: false, imageName: "")
    @State private var review = ""
    @State private var selfieName = ""
    @State private var date = Date()
    @State private var rating = ""
    @State private var latitude = Double()
    @State private var longitude = Double()
    @ObservedObject var reviewViewModel: ReviewViewModel

    let movies: [Movie] = [
        Movie(title: "Aladdin", genre: "fantasy", year: "1992", description: "aladdin y su lampara magica"),
        Movie(title: "Tierra de osos", genre: "adventure", year: "1999", description: "Un humano se convierte en un oso"),
        Movie(title: "La la land", genre: "romance", year: "2019", description: "Bailarines en LA")
    ]
    let ratings = ["★", "★★", "★★★", "★★★★", "★★★★★"]

    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Add a new review")){
                    Picker("Select your movie", selection: $movie.title) {
                        ForEach(movies, id: \.title) { movie in
                            Text(movie.title)
                        }
                    }
                    TextField("Review", text: $review)
                    DatePicker("Date", selection: $date)
                    Picker("Select your rating", selection: $rating) {
                        ForEach(ratings, id: \.self) { rating in
                            Text(rating)
                        }
                    }
                    //FALTA AGREGAR LA SELFIE Y LA UBI
                }
            }
            .navigationTitle("New Review Entry")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    //El save buttos debe ser activado SOLO cuando se llenaron todos los espacios
                    Button("Save"){
                        //falta poner el espacio de la selfie, tambien en la funcion de add vie, se cambia cuando se agregue lo del picker
                        reviewViewModel.addReview(movie: movie, review: review, selfie: UIImage(systemName: "photo" ), date: date, rating: rating, latitude: latitude, longitude: longitude)
                        presentationMode.wrappedValue.dismiss()
                        
                    }
                }
            }
        }
    }
    
}

#Preview {
    AddReviewView(reviewViewModel: .init())
}
