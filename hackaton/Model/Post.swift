//
//  Post.swift
//  hackaton
//
//  Created by José Ángel del Monte Salazar on 06/03/24.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Post: Identifiable, Codable, Equatable, Hashable{
    @DocumentID var id: String?
    var text: String
    var imageURL: URL?
    var imageReferenceID: String = ""
    var publishedDate: Date = Date()
    var likedIDs: [String] = []
    var dislikedIDs: [String] = []
    // Basic user info
    var userName: String
    var userUID: String
    var userProfile: URL? // Cambiado a opcional para manejar URLs nulos
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case imageURL
        case imageReferenceID
        case publishedDate // Corregido de 'publishedData' a 'publishedDate'
        case likedIDs
        case dislikedIDs
        case userName
        case userUID
        case userProfile
    }
}


