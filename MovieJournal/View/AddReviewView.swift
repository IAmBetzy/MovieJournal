//
//  AddReviewView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 24/02/25.
//

import SwiftUI
import MapKit

struct AddReviewView: View {
    @Environment(\.presentationMode) var presentationMode
 
    var selectedMovie: Movie?
    
    @State private var movie: Movie
    @State private var review = ""
    @State private var selfie: UIImage? = nil
    @State private var date = Date()
    @State private var rating = ""
    @State private var latitude = Double()
    @State private var longitude = Double()
    @State private var showImagePicker = false
    @State private var showingActionSheet = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @ObservedObject var reviewViewModel: ReviewViewModel
    @ObservedObject var movieViewModel: MovieViewModel
    @StateObject private var locationManager = LocationManager()

    //pasar al ReviewViewModel
    let ratings = ["★", "★★", "★★★", "★★★★", "★★★★★"]

    init(reviewViewModel: ReviewViewModel, movieViewModel: MovieViewModel, selectedMovie: Movie? = nil) {
            self.reviewViewModel = reviewViewModel
            self.movieViewModel = movieViewModel
            //se agrego para facilitar al usuario agregar una review directamente de la pelicula
            self.selectedMovie = selectedMovie
            _movie = State(initialValue: selectedMovie ?? Movie(title: "", genre: "", year: "", description: "", watched: false, imageName: ""))
        }
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Add a new review")){
                    Picker("Select your movie", selection: $movie) {
                        ForEach(movieViewModel.movies, id: \.title) { movie in
                            Text(movie.title).tag(movie)
                        }
                    }
                    HStack{
                        Button("Añadir foto") {
                            showingActionSheet = true
                        }
                        Spacer()
                        if let image = selfie {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    .actionSheet(isPresented: $showingActionSheet) {
                        ActionSheet(title: Text("Choose a source"), message: Text("Select the source for your photo"), buttons: [
                            .default(Text("Camera")) {
                                sourceType = .camera
                                showImagePicker = true
                            },
                            .default(Text("Gallery")) {
                                sourceType = .photoLibrary
                                showImagePicker = true
                            },
                            .cancel()
                        ])
                    }
                    TextField("Review", text: $review)
                    DatePicker("Date", selection: $date)
                    Picker("Select your rating", selection: $rating) {
                        ForEach(ratings, id: \.self) { rating in
                            Text(rating)
                        }
                    }
                }
                Section(header: Text("Choose Location")) {
                    Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                        .frame(height: 200)
                    Button("Obtener ubicación actual") {
                        locationManager.requestLocation()
                    }
                    
                    if locationManager.showLocationAlert {
                        Text("Por favor activa los permisos de localización en Ajustes.")
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
                }
            }
            .navigationTitle("New Review Entry")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Save"){
                        movie.watched = true
                        reviewViewModel.addReview(movie: movie, review: review, selfie: selfie, date: date, rating: rating, latitude: locationManager.region.center.latitude, longitude: locationManager.region.center.longitude)
                        presentationMode.wrappedValue.dismiss()
                        
                    }
                    .disabled(review.isEmpty || movie.title.isEmpty || rating.isEmpty)
                }
                
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $selfie, sourceType: sourceType)
            }
        }
    }
    
}

#Preview {
    AddReviewView(reviewViewModel: .init(), movieViewModel: .init())
}
