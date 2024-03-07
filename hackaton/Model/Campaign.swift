//
//  Campaign.swift
//  hackaton
//
//  Created by Ruben Dario Suarez Diaz on 06/03/24.
//

import Foundation
struct Campaign: Identifiable {
 let name: String
 let description: String
 let imageNames: [String]
 let link: String
 //let location: String    

  var id: String {
    name + description
  }
}
