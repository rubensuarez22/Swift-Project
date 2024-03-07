//
//  SearchUserView.swift
//  hackaton


import SwiftUI
import FirebaseFirestore

struct SearchUserView: View {
    //View properties
    @State private var fetchedUsers:[User] = []
    @State private var searchText: String = ""
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        List{
            ForEach(fetchedUsers){user in
                NavigationLink{
                    ReusableProfileContent(user: user)
                } label: {
                    Text(user.username)
                        .font(.callout)
                        .hAlign(.leading)
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Buscar usuario")
        .searchable(text:$searchText)
        .onSubmit(of: .search, {
            print("Buscar: \(searchText)")
            Task { await searchUsers() }
        })
        .onChange(of: searchText, perform: { newValue in
            print("Valor actualizado de searchText: \(newValue)")
            if newValue.isEmpty {
                fetchedUsers = []
            }
        })


    }
    
    func searchUsers()async{
        do{
            print("Iniciando búsqueda para: \(searchText)")
            let documents = try await Firestore.firestore().collection("Users")
                .whereField("username", isGreaterThanOrEqualTo: searchText)
                .whereField("username", isLessThanOrEqualTo: "\(searchText)\u{f8ff}")
                .getDocuments()

            let users = try documents.documents.compactMap { doc -> User? in
                try doc.data(as: User.self)
                    
            }
            print("Usuarios encontrados: \(users.count)")
            await MainActor.run(body:{
                fetchedUsers = users
            })
            
        }catch{
            print(error.localizedDescription)
            print("Error buscando usuarios: \(error.localizedDescription)")        }
    }
    
}

#Preview {
    MainView()
}
