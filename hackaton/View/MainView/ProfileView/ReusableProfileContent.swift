//
//  ReusableProfileContent.swift
//  hackaton
//
//  Created by José Ángel del Monte Salazar on 03/03/24.
//

import SwiftUI
import SDWebImageSwiftUI
//This is to make the search user feature comoponent reusable to avoid redundant code and also make it easy to display user details simply with an user model object
struct ReusableProfileContent: View {
    var user: User
    @State private var fetchedPosts: [Post] = []
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVStack{
                HStack(spacing: 12) {
                    WebImage(url:user.userProfileURL).placeholder{
//                        pLACEHODLER IMAGE
                        Image("NullProfile")
                            .resizable()
                    }
                    .resizable()
                    .aspectRatio(contentMode:  .fill)
                    .frame(width:100, height: 100)
                    .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(user.username)
                            .foregroundColor(/*@START_MENU_TOKEN@*/Color("appColor")/*@END_MENU_TOKEN@*/)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text(user.userBio == "77668" ? "San Andrés Cholula" : user.userBio)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .lineLimit(3)
//                        Displaying bio ling if given while signing up
                        if let bioLink = URL(string: user.userBioLink)
                        {
                            Link(user.userBioLink, destination: bioLink)
                                .font(.callout)
                                .tint(.blue)
                                .lineLimit(1)
                        }                
                    }
                    .hAlign(.leading)
                }
                badgesView()
                Text("Publicaciones")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .hAlign(.leading)
                    .padding(.vertical,15)
                ReusablePostView(basedOnUID: true, uid: user.userUID, posts: $fetchedPosts)
                
                if !user.participatingCampaigns.isEmpty {
                          Text("Campañas en curso")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .hAlign(.leading)
                            .padding(.vertical, 15)

                          // Display information about participating campaigns here
                    ForEach(user.participatingCampaigns.indices) { index in
                      let campaignID = user.participatingCampaigns[index]
                      // Access campaign details or display a placeholder using campaignID
                      Text("Campaña \(campaignID)")
                        .foregroundColor(.gray)
                        .font(.caption)
                    }

                        }
            }
            .padding(15)
        }
    }
}


