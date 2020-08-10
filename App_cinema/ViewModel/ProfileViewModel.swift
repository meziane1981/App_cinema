//
//  ProfileViewModel.swift
//  App_cinema
//
//  Created by Henry Franceschi on 10/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import Foundation
import SwiftUI

final class ProfileViewModel: ObservableObject {
    // The user that the profile belongs to
    var user: Profile
    var userImage: CGImage
    
    init(userID: Int) {
        // Try to get userData
        if let userData = GameManager.instance.requestUserDetails(userID) {
            self.user = Profile(userData: userData)
        }
        else {
            // If we are not friends with them, we get basic data
            if let basicUserData = GameManager.instance.requestUserBasicInfo(userID) {
                // Create profile from basic data
                self.user = Profile(basicUserData: basicUserData)
            }
            // Use placeholder
            self.user = Profile.placeholderProfile
        }
        self.userImage = GameManager.instance.fetchUserImage(imageName: user.profileImageName, size: ImageSize.medium)
    }
}
