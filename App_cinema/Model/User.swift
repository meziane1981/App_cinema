//
//  User.swift
//  App_cinema
//
//  Created by Henry Franceschi on 06/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

enum PictureSize: String {
    case small = "_small"
    case medium = "_medium"
    case large = "_large"
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
    var image: String
    
    var profileDescription: String
    var isOnline: Bool
    
    var friends: [Int]
    var statistics: Statistics
    
    init(id: Int, firstName: String, lastName: String, gender: Gender, age: Int, nickName: String, image: String, profileDescription: String, isOnline: Bool, friends: [Int], statistics: Statistics) {
        self.id = id
        
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.age = age
        
        self.nickName = nickName
        self.image = image
        self.profileDescription = profileDescription
        self.isOnline = isOnline
        
        self.friends = friends
        self.statistics = statistics
    }
    
    func getProfileImage(size: PictureSize) -> Image {
        var cgImage: CGImage? = ImageStore.instance.getCGImage(imageName: image + size.rawValue)
        
        if cgImage == nil {
             cgImage = ImageStore.instance.getCGImage(imageName: "user_default" + size.rawValue)
        }
        return Image(cgImage!, scale: 1, label: Text("profile image"))
    }
}



struct BasicUserData: Decodable, Identifiable {
    var id: Int
    
    var nickName: String
    var image: String
    
    var firstName: String
    var lastName: String
    var gender: Gender
    
    func getProfileImage(size: PictureSize) -> Image {
        var cgImage: CGImage? = ImageStore.instance.getCGImage(imageName: image + size.rawValue)
        
        if cgImage == nil {
             cgImage = ImageStore.instance.getCGImage(imageName: "user_default" + size.rawValue)
        }
        return Image(cgImage!, scale: 1, label: Text("profile image"))
    }
}

enum RankScoreByTime: Int {
    case day = 1, week = 7, month = 30
}

struct Statistics: Codable {
    var hoursPlayed: Double
    var coins: Int
    var pointsLast30Days: [Int]
    
    func scoreSum (days: RankScoreByTime?) -> Int {
        var scoreTotal: Int = 0
        
        if let myValue = days {
            for index in 0..<myValue.rawValue {
                scoreTotal += pointsLast30Days[index]
            }
        } else {
            scoreTotal = 99
        }
        
        return scoreTotal
    }
}

enum Gender: String, Codable {
    case male, female
}
