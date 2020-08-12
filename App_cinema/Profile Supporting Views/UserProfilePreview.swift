//
//  UserProfilePreview.swift
//  App_cinema
//
//  Created by Henry Franceschi on 11/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

struct UserProfilePreview: View {
    var user: ProfilePreview
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image(user.profileImage, scale: 1, label: Text("\("Profile picture of " + user.nickName)"))
                    .renderingMode(.original)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(lineWidth: 5).foregroundColor(Color.offWhite1))
                    .background(ZStack {
                        Circle()
                            .shadow(color: Color.black.opacity(0.2), radius: 15, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.7), radius: 15, x: -5, y: -5)
                })
            }

            HStack(alignment: .firstTextBaseline, spacing: 3.5) {
                VStack(alignment: .leading, spacing: 1) {
                    Text(user.nickName)
                        .font(.footnote)
                    Text("#\(user.id)")
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                    
                }
                StatusIndicator(isOnline: user.isOnline ?? false)
            }
            .padding(5)
            .frame(width: 90.0, height: 40.0)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.offWhite1))
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.5), radius: 5, x: -5, y: -5)
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.offWhite1))
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 10, y: 10)
        .shadow(color: Color.white.opacity(0.5), radius: 5, x: -5, y: -5)
    }
}


struct UserProfilePreview_Previews: PreviewProvider {
    static var previews: some View {
        UserProfilePreview(user: ProfilePreview(basicUserData: GameManager.instance.requestUserBasicInfo(GameManager.instance.currentUser.id)!))
    }
}
