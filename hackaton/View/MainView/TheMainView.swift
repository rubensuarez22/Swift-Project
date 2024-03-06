//
//  TheMainView.swift
//  hackaton
//
//  Created by José Ángel del Monte Salazar on 06/03/24.
//

import SwiftUI

let badges = ["leaf.fill", "flame.fill", "drop.fill"]
let campaigns = [
    ("Cleaning campaign", "Your community will get together to clean the main square.", "reciclaje"),
    ("Donation campaign", "Your community is gathering clothing to donate to the city's orphanage.","ayuda")
]
let appsGreen = Color(red: 112/255, green: 224/255, blue: 0/255)

struct TheMainView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                HStack {
                    // Logo de la aplicación a la izquierda
                    VStack(alignment: .leading) {
                        Image("logo_app")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .padding(.leading,20)
                    }
                    
                    Spacer() // Agrega un espacio flexible para separar los elementos
                    
                    // Personas y texto a la derecha
                    HStack {
                        Image(systemName: "person.3.fill")
                            .foregroundColor(appsGreen)
                        
                        Text("250") // Puntaje o moneda
                            .font(.title)
                            .padding()
                    }
                }
                HStack(alignment: .center) {
                    Image("logoCholula") // Reemplaza con el nombre de tu imagen del escudo de la ciudad
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding()
                }
                
                Text("San Andres Cholula")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.leading, .bottom])
                
                ZStack {
                    VStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(appsGreen) // Fondo verde para el título
                            .frame(height: 30)
                            .overlay(
                                Text("Insignias")
                                    .foregroundColor(.white)
                                    .padding(.top, 5),
                                alignment: .top
                            )
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(appsGreen.opacity(0.1)) // Fondo blanco para las insignias
                            .frame(height: 80)
                            .overlay(
                                HStack(spacing: 30) {
                                    ForEach(badges, id: \.self) { badge in
                                        Image(systemName: badge)
                                            .font(.largeTitle)
                                            .foregroundColor(appsGreen)
                                            .frame(width: 60, height: 60)
                                            .background(Circle().fill(Color.white))
                                            .overlay(Circle().stroke(appsGreen, lineWidth: 1))
                                    }
                                }
                                .padding(.top, 10), // Un pequeño padding para bajar las insignias desde el borde superior
                                alignment: .top
                            )
                    }
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                }
                .background(appsGreen.opacity(0.2))
                .padding() // Añadir padding general si es necesario

                
                ForEach(campaigns, id: \.0) { campaign in
                    HStack {
                        Image(campaign.2) // Usa el nombre de la imagen asociada a la campaña
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                        
                        VStack(alignment: .leading) {
                            Text(campaign.0)
                                .font(.headline)
                                .padding(.top)
                            Text(campaign.1)
                                .font(.subheadline)
                                .padding(.bottom)
                        }
                        Spacer()
                    }
                    .background(appsGreen.opacity(0.2))
                    .cornerRadius(10)
                .padding([.leading, .trailing, .top])
                }
            }
        }
    }
}

#Preview {
    TheMainView()
}
