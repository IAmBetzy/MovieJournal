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

//maybe inside view model
struct ReviewLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct ReviewDetailView: View {
    var review: Review
    @StateObject private var locationManager = LocationManager()
    @State private var trackingMode: MapUserTrackingMode = .follow

    
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
                    HStack(alignment: .bottom) {
                        ZStack{
                            NavigationLink(destination: MovieDetailView(movie: review.movie, reviewViewModel: ReviewViewModel(), movieViewModel: MovieViewModel())) {
                                Text(review.movie.title)
                                    .font(.title)
                                    .foregroundStyle(.primary)
                            }
                            //tapa lo de arriba pq no supe como hacer el texto bonito (black no funciona por nightmode)
                            Text(review.movie.title)
                                .font(.title)
                        }
                        
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
                    }
                    Text("Ubicación")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    let reviewLocation = (review.latitude != nil && review.longitude != nil) ?
                    CLLocationCoordinate2D(latitude: review.latitude!, longitude: review.longitude!) : nil
                    
                    Map(
                        coordinateRegion: $locationManager.region,
                        interactionModes: .all,
                        showsUserLocation: true,
                        userTrackingMode: $trackingMode,
                        annotationItems: reviewLocation != nil ? [ReviewLocation(coordinate: reviewLocation!)] : []
                    ) { location in
                        MapMarker(coordinate: location.coordinate, tint: .red)
                    }
                    .frame(height: 200)
                    .cornerRadius(10)
                    .shadow(radius: 5)
   
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
