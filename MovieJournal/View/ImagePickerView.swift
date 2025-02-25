//
//  ImagePickerView.swift
//  Clase_44
//
//  Created by Gabriela Sanchez on 16/01/25.
//

import SwiftUI
import PhotosUI

struct ImagePickerView: View {
    @Binding var image: UIImage?
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(10)
                    .padding()
            } else {
                Text("No Image Selected")
                    .foregroundColor(.gray)
                    .padding()
            }
            
                Button(action: {
                    sourceType = .photoLibrary
                    showImagePicker = true
                }) {
                    Label("Select Image", systemImage: "photo")
                }
                .buttonStyle(.bordered)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $image, sourceType: sourceType)
        }
    }
}
