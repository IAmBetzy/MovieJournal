//
//  WikiButtonView.swift
//  MovieJournal
//
//  Created by Claudia Moca on 16/04/25.
//

import SwiftUI

struct WikiButtonView: View {
    var actor: Actor
    
    var body: some View {
        HStack {
            //Muestra la imagen del actor/actriz
            Image(actor.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 70, alignment: .center)
                .cornerRadius(3)
            //Muestra el nombre
            Text(actor.name)
                .font(.headline)
            Spacer()
        }
    }
}

#Preview {
    WikiButtonView(actor: Actor(name: "Nombre Nombre", wikiLink: URL(string: "http.a"), imageName: "BradPitt"))
}
