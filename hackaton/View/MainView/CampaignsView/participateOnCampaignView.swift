//
//  participateOnCampaignView.swift
//  hackaton
//
//  Created by Ruben Dario Suarez Diaz on 07/03/24.
//

import SwiftUI

struct ParticipateOnCampaignView: View {
    var campaign: Campaign
    @EnvironmentObject private var vm: LocationsViewModel
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @AppStorage("shouldShowLocationsView") var shouldShowLocationsView: Bool = false
    @Environment(\.presentationMode) var presentationMode
    var navigateToLocations: (() -> Void)? = nil


  var body: some View {
    VStack(spacing: 20) {
      Text(campaign.name)
        .font(.title)
        .fontWeight(.bold)
      Text(campaign.description)
        .font(.body)
        .multilineTextAlignment(.leading)
      // Add detailed information section here (optional)
        Button(action: {
            if let location = vm.locations.first(where: { $0.name == campaign.name }) {
                // Configura el estado para la presentación de LocationDetailView
                vm.selectedLocationForDetail = location
                presentationMode.wrappedValue.dismiss() // Cierra la hoja actual
            }
        }) {
            Text("Participar")
              .foregroundColor(.white)
              .padding()
              .background(Color.green)
              .cornerRadius(8)
        }
      Spacer() // Push content to top
    }
    .padding()
    .navigationTitle("Detalles") // Set navigation title
  }
}


