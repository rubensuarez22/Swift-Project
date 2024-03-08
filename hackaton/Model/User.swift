//
//  User.swift
//  hackaton
//


import SwiftUI
import FirebaseFirestoreSwift

struct User: Identifiable,Codable{
    @DocumentID var id: String?
    var username: String
    var userBio: String
    var userBioLink: String
    var userUID: String
    var userEmail: String
    var userProfileURL: URL?
    var participatingCampaigns: [String]?
    var postalCode: String?
    
    enum CodingKeys: CodingKey{
        case id
        case username
        case userBio
        case userBioLink
        case userUID
        case userEmail
        case userProfileURL
        case participatingCampaigns
        case postalCode
    }

}
