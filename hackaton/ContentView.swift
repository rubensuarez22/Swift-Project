//
//  ContentView.swift
//  hackaton
//
//  
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View {
//        Redirecting user based on log status
        if logStatus{
            MainView()
        } else {
            notLoggedInView()
        }
    }
}

#Preview {
    ContentView()
}
