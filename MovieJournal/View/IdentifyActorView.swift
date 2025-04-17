
//
//  IdentifyActorView.swift
//  MovieJournal
//
//  Created by Claudia Moca on 15/04/25.
//

import SwiftUI

//This view merges LivePreviewView with the label of the predictions
struct IdentifyActorView: View {
    @StateObject private var liveViewModel = LiveViewModel()
    @ObservedObject var actorViewModel: ActorViewModel
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack(alignment: .bottom) {
            //LiveVideo
            LivePreviewView(session: liveViewModel.liveScreen.session)
                .edgesIgnoringSafeArea(.all)
            
            //prediction
            ScrollView(.horizontal) {
                HStack {
                    ForEach(liveViewModel.actorQueue, id: \.self) { name in
                        if let actor = actorViewModel.actors.first(where: { $0.name == name }), let url = actor.wikiLink {
                            Link(destination: url) {
                                WikiButtonView(actor: actor)
                                    .foregroundColor(.black)
                                    .padding(7.0)
                                    .frame(minWidth: 200.0)
                                    .  background {
                                        Color.black.opacity(0.2)
                                            .cornerRadius(5)
                                    }
                            }
                        } }
                }
                .padding(.leading)
            }
            .padding(.bottom, 10.0)
            //Cada vez que se salga y vuelva a la pantalla se resetea el queue. Sustitucion para no crear una nueva instancia cada que se accede a la camara
            .onChange(of: selectedTab) { newValue in
                if newValue == 1 {
                    liveViewModel.actorQueue.removeAll()
                }
            }
        }
    }
}


//#Preview {
//    IdentifyActorView(actorViewModel: ActorViewModel(), selectedTab: )
//}
