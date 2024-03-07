//
//  TheMainView.swift
//  hackaton


import SwiftUI

let appsGreen = Color(red: 112/255, green: 224/255, blue: 0/255)

struct TheMainView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center) { // Alineación central para todo excepto "Eventos próximos"
                HStack {
                    // Logo de la aplicación a la izquierda
                    Image("logo_app")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .padding(.leading, 20)
                    
                    Spacer() // Espacio flexible
                    
                    // Icono de personas y texto a la derecha
                    HStack {
                        Image(systemName: "person.3.fill")
                            .foregroundColor(appsGreen)
                        
                        Text("250") // Puntaje o moneda
                            .font(.title)
                            .padding()
                    }
                }
                
                Image("logoCholula") // Imagen del escudo de la ciudad
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding()
                
                Text("San Andres Cholula")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.leading, .bottom, .trailing])
                
                // Alineación específica para "Eventos próximos"
                HStack {
                    Text("Eventos")
                    Text("proximos")
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color("appColor")/*@END_MENU_TOKEN@*/)
                    
                         // Añade padding solo a la izquierda para alinear el texto a la izquierda
                    Spacer() // Este Spacer empuja el texto a la izquierda
                } 
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
              
                
                CampaignsView() // Vista de campañas
            }
            .padding() // Padding general para el VStack exterior
        }
    }
}

#Preview {
    TheMainView()
}
