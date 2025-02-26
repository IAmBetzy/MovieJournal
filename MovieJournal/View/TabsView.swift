//
//  TabView.swift
//  MovieJournal
//
//  Created by Claudia Moca on 26/02/25.
//

import SwiftUI

struct TabsView: View {
    @State var selectedTab = 0

        var body: some View {
            NavigationStack {
                ZStack(alignment: .bottom) {
                    TabView(selection: $selectedTab) {
                        MainView(movieViewModel: MovieViewModel())
                            .tag(0)
                        ReviewsView(reviewViewModel: ReviewViewModel(), movieViewModel: MovieViewModel())
                            .tag(1)
                    }

                    ZStack {
                        HStack {
                            Spacer()
                            Button {
                                selectedTab = 0
                            } label: {
                                CustomTabItem(imageName: "house", imageName2: "house.fill", title: "Inicio", isActive: (selectedTab == 0))
                            }
                            Spacer()
                            Button {
                                selectedTab = 1
                            } label: {
                                CustomTabItem(imageName: "list.bullet.rectangle.portrait", imageName2: "list.bullet.rectangle.portrait.fill", title: "Reviews", isActive: (selectedTab == 1))
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
    func CustomTabItem(imageName: String, imageName2: String, title: String, isActive: Bool) -> some View{
        VStack(spacing: 10){
            Spacer()
            Image(systemName: isActive ? imageName2 : imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                //.renderingMode(.template)
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
