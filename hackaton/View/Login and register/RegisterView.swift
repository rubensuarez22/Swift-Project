//
//  RegisterView.swift
//  hackaton
//
//  Created by José Ángel del Monte Salazar on 03/03/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import PhotosUI

struct RegisterView: View{
    @State var emailID: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    @State var userBio: String = ""
    @State var userBioLink: String = ""
    @State var userProfilePicData: Data?
    //    View Properties
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker: Bool = false
    @State var photoItem: PhotosPickerItem?
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
//    User defaults
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNamestored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    var body: some View{
        VStack(spacing: 10){
            Text("Regístrate")
                .font(.largeTitle.bold())
                .hAlign(.leading)
            
            Text("Bienvenido, ten una increible experiencia")
                .font(.title3)
                .hAlign(.leading)
            
            //            For smaller size optimization
            ViewThatFits{
                ScrollView(.vertical, showsIndicators: false){
                    HelperView()
                }
                HelperView()
            }
            //            Register button
            HStack{
                Text("Ya tienes una cuenta?")
                    .foregroundColor(.gray)
                
                Button("Inicia sesión"){
                    dismiss()
                }
                .fontWeight(.bold)
                .foregroundColor(Color("appColor"))
            }
            .font(.callout)
            .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(15)
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem){ newValue in
            //            Extracting UI Image fron PhotoItem
            if let newValue{
                Task{
                    do{
                        guard let imageData = try await newValue.loadTransferable(type: Data.self) else{return}
                        //                        UI Must be updated on main thread
                        await MainActor.run(body: {
                            userProfilePicData = imageData
                        })
                    }catch{}
                }
            }
        }
//        Displaying alert
        .alert(errorMessage, isPresented: $showError, actions: {})
    }
    
    @ViewBuilder
    func HelperView()->some View{
        VStack(spacing: 12){
            ZStack{
                if let userProfilePicData = userProfilePicData, let image = UIImage(data: userProfilePicData) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode:  .fill)
                } else {
                    Image("NullProfile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        
                }

                    
            }
            .frame(width: 85,height: 85)
            .clipShape(Circle())
            .contentShape(Circle())
            .onTapGesture {
                showImagePicker.toggle()
        
            }
            .padding(.top,25)
            
            TextField("Nombre de usuario", text: $userName)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            TextField("Correo", text: $emailID)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            SecureField("Contraseña", text: $password)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            TextField("ZIP Code", text: $userBio)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            TextField("Link a tu biografía (opcional)", text: $userBioLink)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            Button (action: registerUser) {
                //                    Login button
                Text("Registrarse")
                    .foregroundColor(.white)
                    .hAlign(.center)
                    .fillView(Color("appColor"))
            }
            .disableWithOpacity(userName.isEmpty || userBio.isEmpty || emailID.isEmpty || password.isEmpty || userProfilePicData == nil)
            .padding(.top, 10)
        }
    }
    func registerUser(){
        isLoading = true
        closeKeyboard()
        Task{
            do{
//                First, create a firebase accounte
                try await Auth.auth().createUser(withEmail: emailID, password: password)
//                Second, Upload profile poto to firebase storage
                guard let userUID = Auth.auth().currentUser?.uid else {return}
                guard let imageData = userProfilePicData else {return}
                let storageRef = Storage.storage().reference().child("Profile_Images").child(userUID)
                let _ = try await storageRef.putDataAsync(imageData)
//                Third, download photo url
                let downloadURL = try await storageRef.downloadURL()
//                Fourth, create user firestore object
                let user = User(username: userName, userBio: userBio, userBioLink: userBioLink, userUID: userUID, userEmail: emailID, userProfileURL: downloadURL, participatingCampaigns: [])
//                Fift, Saving user document into Firestore DB
                let _ = try Firestore.firestore().collection("Users").document(userUID).setData(from: user, completion: { error in
                    if error == nil{
//                        Print saved
                        print("Saved succesfully")
                        userNamestored = userName
                        self.userUID = userUID
                        profileURL = downloadURL
                        logStatus = true
                    }
                })
                
            }catch{
//                Delete created account in case of failure
                
                await setError(error)
            }
        }
    }
    
    func setError(_ error: Error)async{
        //        must be defined on main thread
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
