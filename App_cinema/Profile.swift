//
//  Profile.swift
//  App_cinema
//
//  Created by Henry Franceschi on 05/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

struct UserProfilePreview: View {
    var user: BasicUserData

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                user.getProfileImage(size: ImageSize.small)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)

                HStack(alignment: .center, spacing: 0) {
                    Text(user.nickName)
                    Text("#\(user.id)")
                        .font(.caption)
                        .fontWeight(.thin)
                }

            }
            // To be removed
            HStack() {
                Text("\(user.firstName) \(user.lastName)(\(user.gender.rawValue == Gender.male.rawValue ? "m" : "f"))")
            }
        }
    }
}

struct ProfileView: View {
    
    @ObservedObject var profileVM: ProfileViewModel
    
    // Progression
    var percentage: Int = 75
    
    // Style
    var primaryViewColor = Color(red: 4 / 255, green: 19 / 255, blue: 83 / 255)
    
    var body: some View {
        
        VStack {
            ZStack {
                primaryViewColor
                
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.offWhite.opacity(0.95))
                            .frame(width: UIScreen.main.bounds.size.width, height: 300)
                        
                        ZStack {
                            Image(profileVM.userImage, scale: 1, label: Text("\("Profile picture of " + profileVM.user.nickName)"))
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                            
                            VStack(spacing: 0) {
                                HStack(alignment: .center, spacing: 5) {
                                    Text(profileVM.user.nickName)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    Circle()
                                        .fill(profileVM.user.isOnline ?? false ? LinearGradient.profileOnlineIndicatorGradient : LinearGradient.profileOfflineIndicatorGradient)
                                        .frame(width: 10, height: 10)
                                        .shadow(color: Color.green.opacity(0.7), radius: 2, x: 1.5, y: 1.5)
                                }
                                Text("#\(profileVM.user.id)")
                                    .font(Font.system(size: 10))
                            }
                            .padding(.top, 170)
                        }
                        .foregroundColor(.black)
                    }
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profileVM: ProfileViewModel(userID: GameManager.instance.currentUser.id))
    }
}
