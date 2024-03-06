//
//  campaignsView.swift
//  hackaton
//
//  Created by Ruben Dario Suarez Diaz on 06/03/24.
//

import SwiftUI

struct CampaignsView: View { // Renamed struct for clarity
    @State private var campaigns: [Campaign] = campaignsData.campaigns // Updated data source

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(campaigns) { campaign in
                    Button(action: {
                        // Handle button action, like navigating to another view
                    }) {
                        HStack {
                            imageSection(for: campaign)
                            textSection(for: campaign)
                        }
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(10)
                        .padding([.leading, .trailing, .top])
                    }
                    Spacer() // Add spacer for consistent spacing
                }
            }
            .navigationBarTitle("Campañas") // Add navigation bar title
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
            Text(campaign.description)
                .font(.subheadline)
                .lineLimit(2) // Limit description lines to 2
                .padding(.bottom)
        }
    }
}

#Preview {
    CampaignsView()
}


