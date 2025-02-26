//
//  ReviewDetailView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 24/02/25.
//

import SwiftUI
import MapKit

//FALTA LOCaTION
//click en el nombre de la pelicula te lleva a detail view de la pelicula

struct ReviewDetailView: View {
    var review: Review
    @StateObject private var locationManager = LocationManager()

    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                Image(review.movie.imageName)
                //modificar para que se vea bonito
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 250, alignment: .center)
                    .padding(.top, 30.0)
            }
            HStack {
                VStack(alignment: .leading, spacing: 10){
                    HStack() {
                        Text(review.movie.title)
                            .font(.title)
                        Text(review.movie.year)
                        
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        Text(review.rating)
                            .padding()
                            .font(.subheadline)
                    }
                    HStack(spacing: 5) {
                        Text("Seen on:")
                        Text(review.date, style: .date)
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                    Text(review.review)
                        .font(.subheadline)
                    HStack {
                        if let selfie = review.selfie {
                            Image(uiImage: selfie)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 175, height: 200)
                                .cornerRadius(15)
                        } else {
                            Image(systemName: "wrongwaysign.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 175, height: 200)
                                .cornerRadius(15)
                        }
                        //cambiar current location por latitude and longitud de review
                        Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                            .cornerRadius(15)
                        //maybe meter esto al model view
                            .onAppear {
                                locationManager.requestLocation()
                            }
                            .alert("Location Access Denied", isPresented: $locationManager.showLocationAlert) {
                                Button("OK", role: .cancel) {}
                            } message: {
                                Text("Please enable location access in settings to use this feature.")
                            }
                        
                    }
                }
                .padding()
                Spacer()
            }
            
        }
    }
}

#Preview {
    ReviewDetailView(review: Review(movie: Movie(title: "tituloo", genre: "genero", year: "año", description: "descripcion", imageName: "aladdin"), review: "me encanto", selfie: UIImage(systemName: "photo"), date: Date() , rating: "★★"))
}
