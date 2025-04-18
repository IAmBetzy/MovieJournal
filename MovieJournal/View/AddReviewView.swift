//
//  AddReviewView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 24/02/25.
//

import SwiftUI
import MapKit

//Form para agregar una nueva review, se puede accesar desde ReviewsView, o desde un pelicula especifica (boton de agregar review en MovieDetailView)
struct AddReviewView: View {
    @Environment(\.presentationMode) var presentationMode
 
    //Para asociar la review con una pelicula, puede haber varias reviews por pelicula
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
    //Para escoger entre una foto de la galeria o de la camara
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @ObservedObject var reviewViewModel: ReviewViewModel
    @ObservedObject var movieViewModel: MovieViewModel
    @StateObject private var locationManager = LocationManager()

    //Opciones de rating
    let ratings = ["★", "★★", "★★★", "★★★★", "★★★★★"]

    init(reviewViewModel: ReviewViewModel, movieViewModel: MovieViewModel, selectedMovie: Movie? = nil) {
            self.reviewViewModel = reviewViewModel
            self.movieViewModel = movieViewModel
            //se agrego para facilitar al usuario agregar una review directamente de la pelicula
            self.selectedMovie = selectedMovie
        _movie = State(initialValue: selectedMovie ?? Movie(intId: UUID(uuid: (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)), title: "", genre: "", year: "", description: "", watched: false, imageName: ""))
        }
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Add a new review")){
                    //Picker para elegir una pelicula de todas aquellas en la mini base de datos (se muestran los titulos en las opciones)
                    Picker("Select your movie", selection: $movie) {
                        ForEach(movieViewModel.movies, id: \.title) { movie in
                            Text(movie.title).tag(movie)
                        }
                    }
                    HStack{
                        //El boton accede un accionSheet que muestra las opciones para agregar una foto (camara o galeria)
                        Button("Añadir foto") {
                            showingActionSheet = true
                        }
                        Spacer()
                        //muestra la imagen elegida actualmente
                        if let image = selfie {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    //accionSheet para elegir entre galeria o camara
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
                    //Text field para agregar un texto de lo que te parecio la pelicula
                    TextField("Review", text: $review)
                    //Escoger una fecha, la actual por default
                    DatePicker("Date", selection: $date)
                    //Elegir una de las 5 opciones de rating
                    Picker("Select your rating", selection: $rating) {
                        ForEach(ratings, id: \.self) { rating in
                            Text(rating)
                        }
                    }
                }
                //Se muestra la ubicacion actual del usuario, la cual sera guardada dentro del review
                Section(header: Text("Your Location")) {
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
                //Boton de cancelar para regresar a la pestaña anterior
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                //Boton para guardar todas las variables del form contestado
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Save"){
                        //automaticamente se marca la pelicula como vista
                        movie.watched = true
                        
                        //to add to database
                        let newReview = PersistenceController.shared.review(movieId: movie.intId, review: review, selfie: selfie, date: date, rating: rating, latitude: latitude, longitude: longitude)
                        PersistenceController.shared.saveContext()
                        reviewViewModel.reviews.append(newReview)
                        
//                        reviewViewModel.addReview(movie: movie, review: review, selfie: selfie, date: date, rating: rating, latitude: locationManager.region.center.latitude, longitude: locationManager.region.center.longitude)
                        
                        
                        //al guardar se regresa a la pantalla anterior
                        presentationMode.wrappedValue.dismiss()
                        
                    }
                    //Se desabilita el bonton "save" hasta que el usuario ingrese su review, la pelicula y el rating
                    .disabled(review.isEmpty || movie.title.isEmpty || rating.isEmpty)
                }
                
            }
            //para mostrar la galeria o la camara
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $selfie, sourceType: sourceType)
            }
        }
    }
    
}

#Preview {
    AddReviewView(reviewViewModel: .init(), movieViewModel: .init())
}
