//
//  hackatonApp.swift
//  hackaton
//
//  Created by José Ángel del Monte Salazar on 02/03/24.
//

import SwiftUI
import Firebase
@main
struct hackatonApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
