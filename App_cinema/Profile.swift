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
    var userData: BasicUserData
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle.fill")
                HStack(alignment: .center, spacing: 0) {
                    Text(userData.userName)
                    Text("(#\(userData.id))")
                        .font(.caption)
                        .fontWeight(.thin)
                }

            }
            // To be removed
            HStack() {
                Text("\(userData.firstName) \(userData.lastName)(\(userData.gender.rawValue == Gender.male.rawValue ? "m" : "f"))")
            }
        }
    }
}

struct Profile: View {
    
    let user = GameManager.getInstance().requestUserDetails(100001)!

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
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.offWhite)
                        .frame(width: UIScreen.main.bounds.size.width, height: 300)
                    
                    ZStack {
                        Image("user_10001_medium")
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 5))
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                        
                        VStack(alignment: .center, spacing: 0) {
                            HStack(alignment: .center, spacing: 5) {
                                Text(user.userName)
                                    .font(.headline)
                                Circle()
                                    .fill(user.isOnline ? onlineIndicatorGradient : offlineIndicatorGradient)
                                    .frame(width: 10, height: 10)
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

//struct Profile_Previews: PreviewProvider {
//    static var previews: some View {
//        Profile(user: GameManager, friends: [BasicUserData])
//    }
//}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
