//
//  MainView.swift
//  hackaton
//
//  Created by José Ángel del Monte Salazar on 03/03/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            Text("Publicaciones recientes")
                .tabItem{
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
                    Text("Publicaciones")
                }
            ProfileView()
                .tabItem{
                    Image(systemName: "gear")
                    Text("Perfil")
                }
        }
//        Changing tab table tint to black
        .tint(.black)
    }
}

#Preview {
    ContentView()
}
