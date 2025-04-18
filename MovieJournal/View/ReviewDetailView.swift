//
//  ReviewDetailView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 24/02/25.
//

import SwiftUI
import MapKit

//Vista que muestra a detalle una reseña

//Estructura para mostrar la ubicacion guardada en la reseña (dada por los attributos latitude y longitude)
struct ReviewLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct ReviewDetailView: View {
    var review: ReviewEntity
    @StateObject private var locationManager = LocationManager()
    @State private var trackingMode: MapUserTrackingMode = .follow
    @ObservedObject var movieViewModel: MovieViewModel
    
    
    
    var body: some View {
        //buscar entre peliculas con id igual
        let movie = movieViewModel.movies.first(where: { $0.intId == review.movieId })
        
        ScrollView{
            VStack(spacing: 20){
                //Muestra la imagen de la pelicula a la que se hizo review
                Image(movie?.imageName ?? "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 250, alignment: .center)
                    .padding(.top, 30.0)
            }
            HStack {
                VStack(alignment: .leading, spacing: 10){
                    //Muestra el titulo y el año de la pelicula en cuestion, asi como el rating que el usuario le dio en esta reseña
                    HStack() {
                        Text(movie?.title ?? "aaa")
                                .font(.title)
                        Text(movie?.year ?? "2000")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Text(review.rating!)
                            .padding()
                            .font(.subheadline)
                    }
                    //Fecha en la que el usuario vio la pelicula
                    HStack(spacing: 5) {
                        Text("Seen on:")
                        Text(review.date!, style: .date)
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                    //Comentarios del usuario acerca de la pelicula
                    Text(review.review!)
                        .font(.subheadline)
                    //Foto que subio el usuario al realizar la reseña
                    HStack {
                        if let selfie = review.selfie {
                            Image(uiImage: UIImage(data: selfie)!)
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
                    //Muestra la ubicacion en la que se encontraba el usuario al hacer la reseña y su ubicacion actual
                    Text("Ubicación")
                        .font(.headline)
                        .foregroundColor(.gray)
                    let reviewLocation = (review.latitude != nil && review.longitude != nil) ?
                    CLLocationCoordinate2D(latitude: review.latitude, longitude: review.longitude) : nil
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

//#Preview {
//    ReviewDetailView(review: Review(movie: Movie(title: "tituloo", genre: "genero", year: "año", description: "descripcion", imageName: "aladdin"), review: "me encanto", selfie: UIImage(systemName: "photo"), date: Date() , rating: "★★"))
//}
