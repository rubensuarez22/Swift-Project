//
//  PostCardView.swift
//  hackaton
//
//  Created by José Ángel del Monte Salazar on 06/03/24.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

struct PostCardView: View {
    var post: Post
    //Callbacks
    var onUpdate: (Post)->()
    var onDelete: () -> ()
    //View properties
    @AppStorage("user_UID") var userUID: String = ""
    @State private var docListener: ListenerRegistration?
    var body: some View {
        HStack(alignment: .top, spacing: 12){
            WebImage(url: post.userProfile)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 35, height: 35)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 6) {
                Text(post.userName)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("appColor"))
                Text(post.publishedDate.formatted(date: .numeric, time: .shortened))
                    .font(.caption2)
                    .foregroundColor(.gray)
                Text(post.text)
                    .textSelection(.enabled)
                    .padding(.vertical,8)
                
                if let postImageURL = post.imageURL{
                    GeometryReader{
                        let size = $0.size
                        WebImage(url: postImageURL)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    .frame(height: 200)
                }
                PostInteraction()
            }
            
        }
        .hAlign(.leading)
        .overlay(alignment: .topTrailing, content: {
            if post.userUID == userUID{
                Menu{
                    Button("Borrar publicacion", role: .destructive){deletePost()}
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.caption)
                        .rotationEffect(.init(degrees: -90))
                        .foregroundColor(.black)
                        .padding(8)
                        .contentShape(Rectangle())
                }
                .offset(x:8)
            }
        })
        .onAppear {
            // Añadiendo solo una vez
            if docListener == nil {
                guard let postID = post.id else { return }
                docListener = Firestore.firestore().collection("Posts").document(postID).addSnapshotListener({snapshot, error in
                    if let snapshot{
                        if snapshot.exists {
                            if let updatedPost = try? snapshot.data(as: Post.self){
                                onUpdate(updatedPost)
                            }
                        } else{
                            onDelete()
                        }
                    }
                })
            }
        }
        .onDisappear{
            if let docListener{
                docListener.remove()
                self.docListener = nil
            }
        }
    }
    // Like, dislike interaction
    @ViewBuilder
    func PostInteraction()->some View{
        HStack(spacing:6){
            Button(action: likePost){
                Image(systemName: post.likedIDs.contains(userUID) ? "hand.thumbsup.fill" : "hand.thumbsup")
                    .foregroundColor(Color("appColor"))
            }
            Text("\(post.likedIDs.count)")
                .font(.caption)
                .foregroundColor(.gray)
            
            Button(action: dislikePost){
                Image(systemName: post.dislikedIDs.contains(userUID) ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                    .foregroundColor(Color("appColor"))
            }
            .padding(.leading,25)
            Text("\(post.dislikedIDs.count)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .foregroundColor(.black)
        .padding(.vertical,8)
    }
    
    //Linking post
    func likePost(){
        Task{
            guard let postID = post.id else{return}
            if post.likedIDs.contains(userUID){
                //Removing User ID from the array
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "likedIDs":FieldValue.arrayRemove([userUID])
                ])
            }else{
                //add user ID to liked array and removing our id from dislike array if added in prior
                
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "likedIDs":FieldValue.arrayUnion([userUID]),
                    "dislikedIDs": FieldValue.arrayRemove([userUID])
                ])
            }
        }
    }
    // Dislike Post
    func dislikePost(){
        Task{
            guard let postID = post.id else{return}
            if post.dislikedIDs.contains(userUID){
                //Removing User ID from the array
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "dislikedIDs": FieldValue.arrayRemove([userUID])
                ])
            } else {
                // Aquí es donde la lógica debe ser corregida para reflejar la acción correcta
                // Añadir user ID al array de dislikes y remover nuestro ID del array de likes si se añadió anteriormente
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "dislikedIDs": FieldValue.arrayUnion([userUID]),
                    "likedIDs": FieldValue.arrayRemove([userUID])
                ])
            }
        }
    }
    
    func deletePost(){
        Task{
            do{
                if post.imageReferenceID != ""{
                    try await Storage.storage().reference().child("Post_Images").child(post.imageReferenceID).delete()
                }
                guard let postID = post.id else{return}
                try await Firestore.firestore().collection("Posts").document(postID).delete()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

