//
//  ContenidoView.swift
//  hackaton
//
//  Created by José Ángel del Monte Salazar on 07/03/24.
//

import SwiftUI

struct ContenidoView: View {
    @EnvironmentObject var navigationVM: NavigationViewModel
    @EnvironmentObject var vm: LocationsViewModel

    var body: some View {
        switch navigationVM.currentView {
        case "main":
            // Aquí deberías tener tu vista o navegación principal
            MainView() // Ejemplo, reemplaza por tu vista principal real
        case "locations":
            LocationsView().environmentObject(vm)
        default:
            Text("Vista no encontrada")
        }
    }
}
