//
//  Profile.swift
//  App_cinema
//
//  Created by Henry Franceschi on 05/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}

struct UserProfilePreview: View {
    var user: BasicUserData
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                user.getProfileImage(size: PictureSize.small)
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

struct Profile: View {
    
    let user = GameManager.instance.requestUserDetails(10001)!

    // Progression
    var percentage: Int = 75
    
    // Style
    var primaryViewColor = Color(red: 4 / 255, green: 19 / 255, blue: 83 / 255)
    var onlineIndicatorGradient = LinearGradient(gradient: Gradient(colors: [
        Color(.green),
        Color(red: 0.0, green: 0.4, blue: 0.0)
    ]), startPoint: .top, endPoint: .bottom)
    var offlineIndicatorGradient = LinearGradient(gradient: Gradient(colors: [
        Color(red: 0.3, green: 0.3, blue: 0.3),
        Color(.gray)
    ]), startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        ZStack {
            primaryViewColor
            
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.offWhite.opacity(0.95))
                        .frame(width: UIScreen.main.bounds.size.width, height: 300)
                    
                    ZStack {
                        user.getProfileImage(size: PictureSize.medium)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                        
                        VStack(spacing: 0) {
                            HStack(alignment: .center, spacing: 5) {
                                Text(user.firstName)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Circle()
                                    .fill(user.isOnline ? onlineIndicatorGradient : offlineIndicatorGradient)
                                    .frame(width: 10, height: 10)
                                    .shadow(color: Color.green.opacity(0.7), radius: 2, x: 1.5, y: 1.5)
                            }
                            Text("#\(user.id)")
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

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
