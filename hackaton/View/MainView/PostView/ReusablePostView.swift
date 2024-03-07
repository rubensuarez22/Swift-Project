//
//  ReusablePostView.swift
//  hackaton

import SwiftUI
import Firebase

struct ReusablePostView: View {
    var basedOnUID: Bool = false
    var uid: String = ""
    @Binding var posts:[Post]
        //View properties
    @State var isFetching: Bool = true
    //Pagination
    @State private var paginationDoc: QueryDocumentSnapshot?
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            LazyVStack{
                if isFetching{
                    ProgressView()
                        .padding(.top,30)
                    
                }else {
                    if posts.isEmpty{
                        Text("No se encontraron publicaciones")
                            .font(.caption)
                            .foregroundColor(Color("appColor"))
                            .padding(.top,30)
                    }else{
                        //Displaing pos
                        Posts()
                    }
                
                }
            }
            .padding(15)
        }
        .refreshable {
            //Scroll to refresh
            //diabling refresh for uid based post's
            guard basedOnUID else {return}
            isFetching = true
            posts = []
            //reseting pagination doc
            paginationDoc = nil
            await fetchPosts()
        }
        .task{
            guard posts.isEmpty else {return}
            await fetchPosts()
        }
    }
    //Displaying fetched posts
    @ViewBuilder
    func Posts()->some View{
        ForEach(posts){post in
            PostCardView(post: post){ updatedPost in
                //Updating post in the array
                if let index = posts.firstIndex(where: { post in
                    post.id == updatedPost.id
                }){
                    posts[index].likedIDs = updatedPost.likedIDs
                    posts[index].dislikedIDs = updatedPost.dislikedIDs
                }
            } onDelete: {
                //Removing Post from the array
                withAnimation(.easeInOut(duration:0.25)){
                    posts.removeAll{post.id == $0.id}
                }
                
            }
            .onAppear{
                if post.id == posts.last?.id && paginationDoc != nil {
                    Task{await fetchPosts()}
                        
                    }   
                }
            }
            Divider()
                .padding(.horizontal,-15)
    }
    

    
    //fetching posts
    //fetching posts
    func fetchPosts() async {
        do {
            var query: Query!
            
            if let paginationDoc{
                 query = Firestore.firestore().collection("Posts")
                    .order(by: "publishedDate", descending: true)
                    .start(afterDocument: paginationDoc)
                    .limit(to: 20)
                
            }else{
                
                 query = Firestore.firestore().collection("Posts")
                    .order(by: "publishedDate", descending: true)
                    .limit(to: 20)
            }
            
            //New query for UID Based document fetch
            // Simply filter the post's which doesnt belong to this UID
            
            if basedOnUID{
                query = query
                    .whereField("userUID", isEqualTo: uid)
            }
            
            
            let docs = try await query.getDocuments()
            let fetchedPosts = docs.documents.compactMap { doc -> Post? in
                try? doc.data(as: Post.self)
            }
            await MainActor.run {
                posts.append(contentsOf: fetchedPosts)
                paginationDoc = docs.documents.last
                self.isFetching = false // Asegúrate de actualizar isFetching para reflejar que la carga ha terminado
            }
        } catch {
            print(error.localizedDescription)
            await MainActor.run {
                self.isFetching = false // También actualiza isFetching en caso de error
            }
        }
    }

}

#Preview {
    MainView()
}
