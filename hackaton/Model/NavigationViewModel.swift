//
//  NavigationViewModel.swift
//  hackaton
//
//  Created by José Ángel del Monte Salazar on 07/03/24.
//

import SwiftUI

class NavigationViewModel: ObservableObject {
    @Published var currentView: String = "main" {
        didSet {
            print("Nueva vista actual: \(currentView)")
        }
    }
}

