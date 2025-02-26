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

struct ReviewsView: View {
    @State private var showAddReviewView: Bool = false
    @ObservedObject var reviewViewModel: ReviewViewModel
    @ObservedObject var movieViewModel: MovieViewModel
    
        
    var body: some View {
        NavigationView {
            List{
                ForEach(reviewViewModel.reviews) {review in NavigationLink(destination: ReviewDetailView(review: review)) {
                    ReviewRowView(review: review)
                        .padding(.leading, -4.0)
                        .padding(.vertical, 3.0)
                }
                    
                }
                .onDelete(perform: reviewViewModel.deleteReview)
            }
            .navigationTitle(Text("Reviews"))
            .toolbar{
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
