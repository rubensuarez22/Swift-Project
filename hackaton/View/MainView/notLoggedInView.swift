//
//  notLoggedInView.swift
//  hackaton

import SwiftUI

struct notLoggedInView: View {
    
    @State var goToRegister: Bool = false
    @State var goToLogin: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            // Logo de la aplicación (necesitarás reemplazar 'logoImageName' con el nombre de tu imagen)
            Image("logo_app")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 200)
                .padding(.top, 70)
            
            Text("EcoAction")
                .font(.largeTitle)
                .fontWeight(.regular)
                .padding(.top, 20)
            
            // Botones de login y registro
            Button(action: {
                goToLogin = true
            }) {
                Text("Iniciar sesión")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.top, 200)
            .padding(.horizontal, 50)
            
            Button(action: {
                goToRegister = true
            }){
                    Text("Registrarse")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle (cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1))
                }
            .fullScreenCover(isPresented: $goToRegister, content: {
                RegisterView()
            })
                .padding(.top, 20)
                .padding(.horizontal, 50)
                
                Spacer()
            }
        .fullScreenCover(isPresented: $goToLogin, content: {
            LoginView()
        })
        .fullScreenCover(isPresented: $goToRegister, content: {
            RegisterView()
        })            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
        }
    }






#Preview {
    notLoggedInView()
}


