//
//  ProfileView.swift
//  hackaton
//
//  Created by José Ángel del Monte Salazar on 03/03/24.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct ProfileView: View {
    //    Profile data
    @State private var myProfile: User?
    @AppStorage("log_status") var logStatus: Bool = false
//    error message, view properties
    @State var errorMessage: String = ""
    @State var showError: Bool = false
    @State var isLoading: Bool = false
    

    var body: some View {
        NavigationStack{
            VStack{
                if let myProfile{
                    ReusableProfileContent(user: myProfile)
                        .refreshable {
                            //                Referesh user data
                            self.myProfile = nil
                            await fetchUserData()
                        }
                    
                }else{
                    ProgressView()
                }
            }
            .navigationTitle("Mi perfil")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Menu{
                        //                        Two actions,
                        //                        logout
                        //                        delete account
                        Button("Cerrar sesión", action: logOutUser)
                        
                        Button("Eliminar cuenta", role: .destructive, action: deleteAccount)
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.init(degrees: 90))
                            .tint(.black)
                            .scaleEffect(0.8)
                    }
                }
            }
        }
        .overlay{
            LoadingView(show: $isLoading)
        }
        .alert(errorMessage, isPresented: $showError){
        }
        .task {
//            This modifier is like onAppear so fetching for the first time only
            if myProfile != nil {return}
//            Intital fetch
            await fetchUserData()
        }
    }
//    fetching user data
    func fetchUserData()async{
        guard let userUID = Auth.auth().currentUser?.uid else {return}
        guard let user = try? await Firestore.firestore().collection("Users").document(userUID).getDocument(as: User.self) else {return}
        await MainActor.run(body: {
            myProfile = user
        })
    }
    
    //    Function to logout user
    func logOutUser(){
        try? Auth.auth().signOut()
        logStatus = false
    }
//    Function to delete user
    func deleteAccount(){
        isLoading = true
        Task{
            do{
                guard let userUID = Auth.auth().currentUser?.uid else {return}
                //            First, deleting profile image from storage
                let reference = Storage.storage().reference().child("Profile_Images").child(userUID)
                 try await reference.delete()
                //            second, deleting firestore user document
               try await Firestore.firestore().collection("Users").document(userUID).delete()
                //            third and last, deleting auth account and setting log status to false
                try  await Auth.auth().currentUser?.delete()
                logStatus = false
            }catch{
                await setError(error)
            }
        }
    }
    func setError(_ error: Error)async{
//        UI Must be run on main thread
        await MainActor.run(body: {
            isLoading = false
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
    
}

#Preview {
    ProfileView()
}
