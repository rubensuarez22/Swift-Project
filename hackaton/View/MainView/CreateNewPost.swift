//
//  CreateNewPost.swift
//  hackaton
//
//  Created by José Ángel del Monte Salazar on 06/03/24.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage

struct CreateNewPost: View {
    //Callbacks
    var onPost: (Post) ->()
    //Post properties
    @State private var postText: String = ""
    @State private var postImageData: Data?
    //Stored User Data From UserDefaults(AppStorage)
    @AppStorage("user_profile_url") private var profileURL: URL?
    @AppStorage("user_name") private var userName: String = ""
    @AppStorage("user_UID") private var userUID: String = ""
    // View properties
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var photoItem: PhotosPickerItem?
    @FocusState private var showKeyBoard: Bool
    var body: some View {
        VStack{
            HStack{
                Menu{
                    Button("Cancel", role: .destructive){
                        dismiss()
                    }
                } label: {
                    Text("Cancelar")
                        .font(.callout)
                        .foregroundColor(.black)
                }
                .hAlign(.leading)
                Button(action: createPost){
                    Text("Publicar")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical,6)
                        .background(.black, in:Capsule())
                }
                .disableWithOpacity(postText == "")
            }
            .padding(.horizontal,15)
            .padding(.vertical, 10)
            .background{
                Rectangle()
                    .fill(.gray.opacity(0.05))
                    .ignoresSafeArea()
            }
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15){
                    TextField("Que esta pasando?", text: $postText, axis: .vertical)
                        .focused($showKeyBoard)
                    if let postImageData, let image = UIImage(data: postImageData){
                        GeometryReader{
                            let size = $0.size
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height:size.height)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            //delete button
                                .overlay(alignment: .topTrailing){
                                    Button{
                                        withAnimation(.easeInOut(duration: 0.25)){
                                            self.postImageData = nil
                                        }
                                        
                                    } label: {
                                        Image(systemName: "trash")
                                            .fontWeight(.bold)
                                            .tint(.red)
                                    }
                                    .padding(10)
                                }
                        }
                        .clipped()
                        .frame(height:220)
                    }
                }
                .padding(15)
            }
            Divider()
            HStack{
                Button{
                    showImagePicker.toggle()
                } label: {
                    Image(systemName: "photo.on.rectangle")
                        .font(.title3)
                        .foregroundColor(.black)
                }
                .hAlign(.leading)
                
                Button("Done"){
                    showKeyBoard = false
                }
            }
            .foregroundColor(.black)
            .padding(.horizontal, 15)
            .padding(.vertical,10)
        }
        .vAlign(.top)
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem) { newValue in
            if let newValue{
                Task {
                    do {
                        let rawImageData = try await newValue.loadTransferable(type: Data.self)
                        if let image = UIImage(data: rawImageData!),
                           let compressedImageData = image.jpegData(compressionQuality: 0.5) {
                            await MainActor.run {
                                postImageData = compressedImageData
                                photoItem = nil
                            }
                        }
                    } catch {
                        // Manejo del error, por ejemplo, actualizando el estado de la UI para reflejar el error
                        print("Error cargando la imagen: \(error)")
                    }
                }
            }
        }
        .alert(errorMessage, isPresented: $showError, actions:{})
        .overlay {
            LoadingView(show: $isLoading)
        }
    }
    
    // Post content to firebase
    
    func createPost(){
        isLoading = true
        showKeyBoard = false
        Task {
            do{
                guard let profileURL = profileURL else {return}
                //1. uploade image if any
                let imageReferenceID = "\(userUID)\(Date())"
                let storageRef = Storage.storage().reference().child("Post_Images").child(imageReferenceID)
                if let postImageData {
                    let _ = try await storageRef.putDataAsync(postImageData)
                    let downloadURL = try await storageRef.downloadURL()
                    // 3. create post with iamge id and URL
                    let post = Post(text: postText, imageURL: downloadURL, imageReferenceID: imageReferenceID, userName: userName, userID: userUID, userProfile: profileURL)
                    try await createDocumentAtFirebase(post)
                }else {
                    //2. directly poost text data if there is nor image
                    let post = Post(text: postText, userName: userName, userID: userUID, userProfile: profileURL)
                    try await createDocumentAtFirebase(post)
                }
            }catch{
                await setError(error)
            }
        }
        
    }
    
    func createDocumentAtFirebase(_ post: Post)async throws {
        // writing document to firebase
        let _ = try Firestore.firestore().collection("Posts").addDocument(from: post, completion: { error in
            if error == nil {
                isLoading = false
                onPost(post)
                dismiss()
                
            }
        })
    }
    
    //Displaying errors
    
    func setError(_ error: Error)async{
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}
#Preview {
    CreateNewPost{_ in
    }
}
