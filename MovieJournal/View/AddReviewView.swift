//
//  AddReviewView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 24/02/25.
//

import SwiftUI
//AGREGAR PARA QUE TOME FOTO TAMBIEN

struct AddReviewView: View {
    @Environment(\.presentationMode) var presentationMode
 
    @State private var movie = Movie(title: "", genre: "" , year: "", description: "", watched: false, imageName: "")
    @State private var review = ""
    @State private var selfie: UIImage? = nil
    @State private var date = Date()
    @State private var rating = ""
    @State private var latitude = Double()
    @State private var longitude = Double()
    @State private var showImagePickerView: Bool = false
    @ObservedObject var reviewViewModel: ReviewViewModel
    @ObservedObject var movieViewModel: MovieViewModel

    //pasar al ReviewViewModel
    let ratings = ["★", "★★", "★★★", "★★★★", "★★★★★"]

    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Add a new review")){
                    Picker("Select your movie", selection: $movie.title) {
                        ForEach(movieViewModel.movies, id: \.title) { movie in
                            Text(movie.title)
                        }
                    }
                    Button(action: {
                        showImagePickerView = true
                    }) {
                        HStack {
                            Text("Select Photo")
                            Spacer()
                            if let image = selfie {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
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
                        //falta poner el espacio de la selfie, tambien en la funcion de add view, se cambia cuando se agregue lo del picker
                        reviewViewModel.addReview(movie: movie, review: review, selfie: selfie, date: date, rating: rating, latitude: latitude, longitude: longitude)
                        presentationMode.wrappedValue.dismiss()
                        
                    }
                    .disabled(review.isEmpty || movie.title.isEmpty || rating.isEmpty)
                }
                
            }
            .sheet(isPresented: $showImagePickerView) {
                ImagePickerView(image: $selfie)
            }
        }
    }
    
}

#Preview {
    AddReviewView(reviewViewModel: .init(), movieViewModel: .init())
}
