//
//  Profile.swift
//  App_cinema
//
//  Created by Henry Franceschi on 05/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

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
    var percentage: Int = 100
    
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
        Text("Something here")
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
