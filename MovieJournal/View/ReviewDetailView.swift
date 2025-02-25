//
//  ReviewDetailView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 24/02/25.
//

import SwiftUI
import MapKit

struct ReviewDetailView: View {
    var review: Review
    @StateObject private var locationManager = LocationManager()

    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 200, height: 250)
                    .foregroundColor(.yellow)
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
                    
                    Text(review.date, style: .date)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(review.review)
                        .font(.subheadline)
                    HStack {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 175, height: 200)
                            .cornerRadius(15)
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
    ReviewDetailView(review: Review(movie: Movie(title: "tituloo", genre: "genero", year: "año", description: "descripcion"), review: "me encanto", date: Date() , rating: "★★"))
}
