//
//  campaignsData.swift
//  hackaton
//
//  Created by Ruben Dario Suarez Diaz on 06/03/24.
//

import Foundation
class campaignsData {
  static let campaigns: [Campaign] = [
    Campaign(
      name: "Cleaning campaign",
      description: "Your community will get together to clean the main square.",
      imageNames: ["reciclaje"],
      link: ""),
    Campaign(
        name: "Donation campaign",
        description: "Your community is gathering clothing to donate to the city's orphanage.",
        imageNames: ["ayuda"],
        link: "")
  ]
   
}
