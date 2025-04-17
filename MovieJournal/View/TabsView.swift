//
//  TabView.swift
//  MovieJournal
//
//  Created by Claudia Moca on 26/02/25.
//

import SwiftUI

//View para navegar entre la pantalla principal y la pantalla de las reseñas
struct TabsView: View {
    @State var selectedTab = 0
    @StateObject private var permissionsViewModel = PermissionsViewModel()
    @StateObject var movieViewModel = MovieViewModel()
    @StateObject var reviewViewModel = ReviewViewModel()
    @StateObject var actorViewModel = ActorViewModel()
    
    //Al entrar a la aplicacion pregunta por todos los permisos de privacidad del usuario
    init() {
        permissionsViewModel.requestLocationAccess()
        permissionsViewModel.requestCameraAccess()
        permissionsViewModel.requestPhotoLibraryAccess()
        //agregar
        //permissionsViewModel.requestMicrophoneAccess()
        
    }
        var body: some View {
            NavigationStack {
                //Un boton para la pantalla principal y un boton para la pantalla de reviews
                ZStack(alignment: .bottom) {
                    TabView(selection: $selectedTab) {
                        //estoy creando una nueva instancia, quitar
                        MainView(movieViewModel: movieViewModel)
                            .tag(0)
                        IdentifyActorView(actorViewModel: actorViewModel, selectedTab: $selectedTab)
                            .tag(1)
                        //estoy creando una nueva instancia, quitar
                        ReviewsView(reviewViewModel: reviewViewModel, movieViewModel: movieViewModel)
                            .tag(2)
                    }

                    ZStack {
                        HStack {
                            Spacer()
                            //Visual de los botones, su imagen depende de la pantalla en la que el usuario se encuentre y es elegida por la funcion CustonTabItem
                            Button {
                                selectedTab = 0
                            } label: {
                                CustomTabItem(imageName: "house", imageName2: "house.fill", title: "Inicio", isActive: (selectedTab == 0))
                            }
                            Spacer()
                            Button {
                                selectedTab = 1
                            } label: {
                                CustomTabItem(imageName: "camera", imageName2: "camera.fill", title: "", isActive: (selectedTab == 1))
                            }
                            Spacer()
                            Button {
                                selectedTab = 2
                            } label: {
                                CustomTabItem(imageName: "list.bullet.rectangle.portrait", imageName2: "list.bullet.rectangle.portrait.fill", title: "Reviews", isActive: (selectedTab == 2))
                                
                            }
                            Spacer()
                        }
                        .frame(height: 50)
                        .background(.white)
                    }
                    
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
        }
        
    }


extension TabsView{
    //TabItem determina si cierta pantalla esta activa, y con ello especifica la imagen del boton que muestra al usuario
    func CustomTabItem(imageName: String, imageName2: String, title: String, isActive: Bool) -> some View{
        VStack(spacing: 10){
            Spacer()
            Image(systemName: isActive ? imageName2 : imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 15, height: 24)
                
                Text(title)
                    .font(Font.custom("Poppins-Regular", size: 10))
                    .foregroundColor(isActive ? .black : .gray)
        }
        .frame(width: .infinity, height: 60)
    }
}

#Preview {
    TabsView()
}
