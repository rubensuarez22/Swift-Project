//
//  badgesView.swift
//  hackaton


import SwiftUI

struct badgesView: View {
    @State private var badges: [Badges] = badgesData.badges // Datos de los badges
    let appsGreen = Color(red: 112/255, green: 224/255, blue: 0/255)
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(badges) { badge in
                        imageSection(for: badge)
                    }
                }
                .frame(height: 80)
            }
            .padding(.horizontal)
        }
    }
    
    // Extrae la función 'imageSection' que acepta un badge y devuelve una vista
    func imageSection(for badge: Badges) -> some View {
        VStack {
            if let imageName = badge.imageNames.first { // Asumimos que solo queremos mostrar la primera imagen
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 3)
            }
            Text(badge.name) // Muestra el nombre del badge
                .font(.caption)
                .lineLimit(1)
        }
        .padding(3)
    }
}


#Preview {
    badgesView()
}
