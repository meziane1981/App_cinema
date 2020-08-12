//
//  Profile.swift
//  App_cinema
//
//  Created by Henry Franceschi on 10/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

class Profile: Identifiable {
    var id: Int
    var nickName: String
    var profileDescription: Optional<String>
    var isOnline: Optional<Bool>
    var friends: Optional<[Int]>
    var statistics: Optional<Statistics>
    var profileImage: CGImage
    
    public private(set) static var placeholderProfile: Profile = .init(id: 10000, nickName: "defaultUser", imageName: "user_10000", profileDescription: nil, isOnline: nil, friends: nil, statistics: nil)
    
    init(id: Int, nickName: String, imageName: String, profileDescription: Optional<String>, isOnline: Optional<Bool>, friends: Optional<[Int]>, statistics: Optional<Statistics>) {
        self.id = id
        self.nickName = nickName
        self.profileDescription = profileDescription
        self.isOnline = isOnline
        self.friends = friends
        self.statistics = statistics
        self.profileImage = GameManager.instance.fetchUserImage(imageName: imageName, size: ImageSize.medium)
    }
    
    init(userData: UserData) {
        self.id = userData.id
        self.nickName = userData.nickName
        self.profileDescription = userData.profileDescription
        self.isOnline = userData.isOnline
        self.friends = userData.friends
        self.statistics = userData.statistics
        self.profileImage = GameManager.instance.fetchUserImage(imageName: userData.profileImageName, size: ImageSize.medium)
    }
    
    // If we are not friends with a user we will use a reduced profile
    init(basicUserData: BasicUserData) {
        self.id = basicUserData.id
        self.nickName = basicUserData.nickName
        self.profileImage = GameManager.instance.fetchUserImage(imageName: basicUserData.profileImageName, size: ImageSize.medium)
        
        // if we don't have access then we can't set the following
        self.profileDescription = nil
        self.isOnline = nil
        self.friends = nil
        self.statistics = nil
    }
}

class ProfilePreview: Identifiable {
    var id: Int
    var nickName: String
    var isOnline: Optional<Bool>
    var profileImage: CGImage

    // If we are not friends with them then we can't see if they are online
    init(id: Int, nickName: String, profileImageName: String, isOnline: Optional<Bool>) {
        self.id = id
        self.nickName = nickName
        self.isOnline = isOnline
        self.profileImage = GameManager.instance.fetchUserImage(imageName: profileImageName, size: ImageSize.small)
    }
    
    // If we are then we just copy from basic user data and load the image
    init(basicUserData: BasicUserData) {
        self.id = basicUserData.id
        self.nickName = basicUserData.nickName
        self.isOnline = basicUserData.isOnline
        self.profileImage = GameManager.instance.fetchUserImage(imageName: basicUserData.profileImageName, size: ImageSize.small)
    }
    
}
