//
//  ReviewsView.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//

//BARRA DE BUSQUEDA PARA BUSCAR POR PELICULA
//Ordenar por calificacion, fecha

import SwiftUI
import UIKit

//Vista de la lista de reseñas, con boton para agregar una nueva reseña
struct ReviewsView: View {
    @State private var showAddReviewView: Bool = false
    @ObservedObject var reviewViewModel: ReviewViewModel
    @ObservedObject var movieViewModel: MovieViewModel
    
        
    var body: some View {
        NavigationView {
            List{
                //Se muestran todas las reseñas que ha realizado el usuario
                ForEach(reviewViewModel.reviews) {review in NavigationLink(destination: ReviewDetailView(review: review)) {
                    ReviewRowView(review: review)
                        .padding(.leading, -4.0)
                        .padding(.vertical, 3.0)
                }
                    
                }
                //Para eliminar una reseña
                .onDelete(perform: reviewViewModel.deleteReview)
            }
            .navigationTitle(Text("Reviews"))
            .toolbar{
                //Boton para agregar una nueva reseña, se mand a a la pantalla AddReviewView
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddReviewView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddReviewView) {
                AddReviewView(reviewViewModel: reviewViewModel, movieViewModel: movieViewModel)
            }
        }
    }
}

#Preview {
    ReviewsView(reviewViewModel: ReviewViewModel(), movieViewModel: MovieViewModel())
}
