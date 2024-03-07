//
//  MainView.swift
//  hackaton


import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            TheMainView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Principal")
                }
            PostsView()
                .tabItem {
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
                    Text("Publicaciones")
                }
            LocationsView()
                .environmentObject(LocationsViewModel())
                .tabItem{
                    Image(systemName: "map")
                    Text("Mapa")
                }
            ProfileView()
                .tabItem{
                    Image(systemName: "person")
                    Text("Perfil")
                }
            /*
            Text("Ya vere que se hace con esta vista")
                .tabItem{
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
                    Text("Publicaciones")
                }        */
             }
//        Changing tab table tint to black
        .tint(.black)
    }
}

#Preview {
    MainView()
}
