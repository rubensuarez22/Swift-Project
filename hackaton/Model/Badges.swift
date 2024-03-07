//
//  Badges.swift
//  hackaton
//
//  Created by José Ángel del Monte Salazar on 06/03/24.
//

import Foundation
struct Badges: Identifiable {
    let assignedUser: String
    let name: String
    let description: String
    let imageNames: [String]
    let link: String

     var id: String {
       assignedUser + name
     }
}
