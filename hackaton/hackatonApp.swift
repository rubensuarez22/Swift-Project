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
    @StateObject private var vm = LocationsViewModel()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
