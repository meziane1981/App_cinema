//
//  User.swift
//  App_cinema
//
//  Created by Henry Franceschi on 06/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

class Profile {
    var id: Int
    var nickName: String
    var profileImageName: String
    var profileDescription: Optional<String>
    var isOnline: Optional<Bool>
    var friends: Optional<[Int]>
    var statistics: Optional<Statistics>
    
    public private(set) static var placeholderProfile: Profile = .init(id: 10000, nickName: "defaultUser", imageName: "user_10000", profileDescription: nil, isOnline: nil, friends: nil, statistics: nil)
    
    init(id: Int, nickName: String, imageName: String, profileDescription: Optional<String>, isOnline: Optional<Bool>, friends: Optional<[Int]>, statistics: Optional<Statistics>) {
        self.id = id
        self.nickName = nickName
        self.profileImageName = imageName
        self.profileDescription = profileDescription
        self.isOnline = isOnline
        self.friends = friends
        self.statistics = statistics
    }
    
    init(userData: UserData) {
        self.id = userData.id
        self.nickName = userData.nickName
        self.profileImageName = userData.profileImageName
        self.profileDescription = userData.profileDescription
        self.isOnline = userData.isOnline
        self.friends = userData.friends
        self.statistics = userData.statistics
    }
    
    init(basicUserData: BasicUserData) {
        self.id = basicUserData.id
        self.nickName = basicUserData.nickName
        self.profileImageName = basicUserData.profileImageName
        
        // if we don't have access then we can't set the following
        self.profileDescription = nil
        self.isOnline = nil
        self.friends = nil
        self.statistics = nil
    }
}

class UserData: Codable, Identifiable {
    var id: Int
    // Personal Info
    var firstName: String
    var lastName: String
    var gender: Gender
    var age: Int
    // Profile data
    var nickName: String
    var profileImageName: String
    var profileDescription: String
    var isOnline: Bool
    var friends: [Int]
    var statistics: Statistics
    
    init(id: Int, firstName: String, lastName: String, gender: Gender, age: Int, nickName: String, imageName: String, profileDescription: String, isOnline: Bool, friends: [Int], statistics: Statistics) {
        self.id = id
        
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.age = age
        
        self.nickName = nickName
        self.profileImageName = imageName
        self.profileDescription = profileDescription
        self.isOnline = isOnline
        
        self.friends = friends
        self.statistics = statistics
    }
}

struct BasicUserData: Decodable, Identifiable {
    var id: Int
    
    var nickName: String
    var profileImageName: String
    
    var firstName: String
    var lastName: String
    var gender: Gender
    
    func getProfileImage(size: ImageSize) -> Image {
        var cgImage: CGImage? = ImageStore.instance.getCGImage(imageName: profileImageName + size.rawValue)
        
        if cgImage == nil {
             cgImage = ImageStore.instance.getCGImage(imageName: "user_default" + size.rawValue)
        }
        return Image(cgImage!, scale: 1, label: Text("profile image"))
    }
}

struct Statistics: Codable {
    var hoursPlayed: Double
    var coins: Int
    var pointsLast30Days: [Int]
}

enum Gender: String, Codable {
    case male, female
}
