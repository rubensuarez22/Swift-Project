//
//  ReusablePostView.swift
//  hackaton

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ReusablePostView: View {
    var basedOnUID: Bool = false
    var uid: String = ""
    @Binding var posts: [Post]
    
    // Estado para manejar si se está recuperando data.
    @State private var isFetching: Bool = true
    // Estado para almacenar la última referencia de documento para la paginación.
    @State private var paginationDoc: QueryDocumentSnapshot?
    // Referencia para el listener de Firestore, para poder cancelarlo.
    @State private var postsListener: ListenerRegistration?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                if isFetching {
                    ProgressView()
                        .padding(.top, 30)
                } else if posts.isEmpty {
                    Text("No se encontraron publicaciones")
                        .font(.caption)
                        .foregroundColor(Color("appColor"))
                        .padding(.top, 30)
                } else {
                    ForEach(posts) { post in
                        PostCardView(post: post, onUpdate: { updatedPost in
                            // Actualizar post en el array.
                            if let index = posts.firstIndex(where: { $0.id == updatedPost.id }) {
                                posts[index] = updatedPost
                            }
                        }, onDelete: {
                            // Remover post del array.
                            posts.removeAll { $0.id == post.id }
                        })
                        .onAppear {
                            if post.id == posts.last?.id && paginationDoc != nil {
                                Task {
                                    await fetchPosts()
                                }
                            }
                        }
                    }
                }
            }
            .padding(15)
        }
        .refreshable {
            await fetchPosts(reset: true)
        }
        .task {
            if posts.isEmpty {
                await fetchPosts(reset: true)
            }
        }
        .onDisappear {
            // Asegurarse de cancelar el listener cuando la vista desaparezca.
            postsListener?.remove()
        }
    }

    func fetchPosts(reset: Bool = false) async {
        if reset {
            paginationDoc = nil
            postsListener?.remove()
            posts = []
        }
        
        var query: Query = Firestore.firestore().collection("Posts")
            .order(by: "publishedDate", descending: true)
            .limit(to: 20)

        if basedOnUID {
            query = query.whereField("userUID", isEqualTo: uid)
        }

        if let paginationDoc {
            query = query.start(afterDocument: paginationDoc)
        }
        
        // Cancelar el listener anterior si existe.
        postsListener?.remove()
        
        isFetching = true
        postsListener = query.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    self.isFetching = false
                }
                return
            }
            let fetchedPosts = documents.compactMap { doc -> Post? in
                try? doc.data(as: Post.self)
            }
            
            DispatchQueue.main.async {
                if reset || self.paginationDoc == nil {
                    self.posts = fetchedPosts
                } else {
                    self.posts.append(contentsOf: fetchedPosts)
                }
                self.paginationDoc = documents.last
                self.isFetching = false
            }
        }
    }
}



#Preview {
    MainView()
}
