//
//  LoginView.swift
//  hackaton


import SwiftUI
//database
import Firebase
import FirebaseFirestore
import FirebaseStorage


struct LoginView: View {
    //User details
    @State var emailID: String = ""
    @State var password: String = ""
    //    Mark view properties
    @State var createAccount: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
//    User Defaults
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    var body: some View {
        VStack(spacing: 10){
            Text("Inicio de sesión")
                .font(.largeTitle.bold())
                .hAlign(.leading)
            
            Text("Bienvenido de vuelta, \n Te echábamos de menos!")
                .font(.title3)
                .hAlign(.leading)
            
            VStack(spacing: 12){
                TextField("Correo", text: $emailID)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)
                SecureField("Contraseña", text: $password)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                Button("Recuperar contraseña", action:resetPassword)
                    .font(.callout)
                    .fontWeight(.medium)
                    .tint(.black)
                    .hAlign(.trailing)
                
                Button(action: loginUser){
                    //                    Login button
                    Text("Iniciar sesión")
                        .foregroundColor(.white)
                        .hAlign(.center)
                        .fillView(.black)
                }
                .padding(.top, 10)
            }
            
            //            Register button
            HStack{
                Text("No tienes cuenta aún?")
                    .foregroundColor(.gray)
                
                Button("Regístrate"){
                    createAccount.toggle()
                }
                .fontWeight(.bold)
                .foregroundColor(.black)
            }
            .font(.callout)
            .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(15)
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        //        Register view via sheets
        .fullScreenCover(isPresented: $createAccount){
            RegisterView()
        }
        //        Displaying alert
        .alert(errorMessage, isPresented: $showError, actions: {})
    }
    func loginUser(){
        isLoading = true
        closeKeyboard()
        Task{
            do{
                try await Auth.auth().signIn(withEmail: emailID, password: password)
                print("User found")
                try await fetchUser()
            }catch{
                await setError(error)
            }
        }
    }
//    If user if found then fetching user data from firestore
    func fetchUser()async throws {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        let user = try await Firestore.firestore().collection("Users").document(userID).getDocument(as: User.self)
//        UI updating must be run on main thread
        await MainActor.run(body: {
//            Setting userdefaults data and changing app´s auth status
            userUID = userID
            userNameStored = user.username
            profileURL = user.userProfileURL
            logStatus = true
        })
    }
    func resetPassword(){
        Task{
            do{
                try await Auth.auth().sendPasswordReset(withEmail: emailID)
                print("Link sent")
            }catch{
                await setError(error)
            }
        }
    }
//    Display error VIA Alert
    func setError(_ error: Error)async{
//        UI Must be updated on main thread
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
}

//Register view

struct LoginView_Previews: PreviewProvider {
    static var previews: some View{
        LoginView()
    }
}


