//
//  campaignsView.swift
//  hackaton
//
//  Created by Ruben Dario Suarez Diaz on 06/03/24.
//

import SwiftUI

struct CampaignsView: View {
  @State private var campaigns: [Campaign] = campaignsData.campaigns // Updated data source
  @State private var selectedCampaign: Campaign? = nil // Track selected campaign
    
@EnvironmentObject var locationsViewModel: LocationsViewModel
  let appsGreen = Color(red: 112/255, green: 224/255, blue: 0/255)

  var body: some View {
    NavigationView {
      ScrollView {
        ForEach(campaigns) { campaign in
          Button(action: {
              
            selectedCampaign = campaign // Set selected campaign on button tap
              print("Campaña seleccionada: \(campaign.name)")
          }) {
            HStack {
              imageSection(for: campaign)
              textSection(for: campaign)
            }
            .background(appsGreen.opacity(0.2))
            .cornerRadius(10)
            .padding([.leading, .trailing, .top])
            .frame(width: 400, height: 100)
          }
          Spacer() // Add spacer for consistent spacing
        }
      }
      .navigationTitle("Campañas Ambientales") // Set navigation title
    }
    .sheet(item: $selectedCampaign) { campaign in
         ParticipateOnCampaignView(campaign: campaign)
             .environmentObject(locationsViewModel)
             .presentationDetents([.fraction(0.25)])
     }
     .sheet(item: $locationsViewModel.selectedLocationForDetail) { location in
         LocationDetailView(location: location)
             .environmentObject(locationsViewModel)
     }

  }

  private func imageSection(for campaign: Campaign) -> some View {
    HStack {
      if let imageName = campaign.imageNames.first {
        Image(imageName)
          .resizable()
          .frame(width: 60, height: 60)
          .clipShape(RoundedRectangle(cornerRadius: 10))
          .padding()
      }
    }
  }

  private func textSection(for campaign: Campaign) -> some View {
    VStack(alignment: .leading) {
      Text(campaign.name)
        .font(.headline)
        .padding(.top)
        .foregroundColor(.primary)
      Text(campaign.description)
        .foregroundColor(.secondary)
        .font(.subheadline)
        .lineLimit(.none) // Limit description lines to 2
        .padding(.bottom)
        .padding(.trailing)
    }
  }
}

#Preview {
  CampaignsView()
}



