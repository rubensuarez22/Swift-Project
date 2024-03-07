//
//  participateOnCampaignView.swift
//  hackaton
//
//  Created by Ruben Dario Suarez Diaz on 07/03/24.
//

import SwiftUI

struct ParticipateOnCampaignView: View {
  var campaign: Campaign

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
        // Implement participation action (e.g., link to website, open app)
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


