//
//  PostsView.swift
//  hackaton

import SwiftUI


    

struct PostsView: View {
    @State private var recentsPosts: [Post] = []
    @State private var createNewPost: Bool = false
    
    var body: some View {
        NavigationStack{
        ReusablePostView(posts: $recentsPosts)
            .hAlign(.center).vAlign(.center)
            .overlay(alignment: .bottomTrailing) {
                Button {
                    createNewPost.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(13)
                        .background(.black, in: Circle())
                }
                .padding(15)
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SearchUserView()
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .tint(.black)
                            .scaleEffect(0.9)
                    }
                }
            })
            .navigationTitle("Publicaciones")
            }
            .fullScreenCover(isPresented: $createNewPost) {
                CreateNewPost { post in
                    //ading created posts at the top pf tje recemt posts
                    recentsPosts.insert(post, at: 0)
                }
            }
    }
}

#Preview {
    PostsView()
}
