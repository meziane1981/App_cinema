//
//  UserData.swift
//  App_cinema
//
//  Created by Henry Franceschi on 04/08/2020.
//  Copyright © 2020 William Paparone. All rights reserved.
//

import SwiftUI

final class GameManager {
    public private(set) var userData: [UserData]
    public private(set) var publicUserData: [BasicUserData]
    public private(set) var currentUser: UserData
    
    public private(set) static var instance = GameManager(userFile: "UserDataGenerated", quizFile: "QuizData")
    
    private init(userFile: String, quizFile: String) {
        self.userData = loadJSON(userFile)
        self.publicUserData = self.userData.map {
            BasicUserData(id: $0.id, nickName: $0.nickName, profileImageName: $0.profileImageName, isOnline: $0.isOnline)
        }
        // For permissions
        self.currentUser = userData[0]
        }
    
    // Transactions
    
    func requestUserBasicInfo(_ id: Int) -> Optional<BasicUserData> {
        var user = publicUserData.first {
            $0.id == id
        }
        
        if currentUser.id == id || currentUser.friends.contains(id) {
            return user
        } else {
            user?.isOnline = false
            return user
        }
        
    }
    
    // If we are the user or a friends with the user this will return the details
    func requestUserDetails(_ id: Int) -> Optional<UserData> {
        // Need to fix this
        let user = userData.first {
            $0.id == id
        }
        
        // If the profile belongs to the current user or a friend
        if currentUser.id == id || currentUser.friends.contains(id) {
            return user
        }
        else {
            return nil
        }
    }
    
    func fetchUserImage(imageName: String, size: ImageSize) -> CGImage {
        guard let cgImage = ImageStore.instance.getCGImage(imageName: imageName + size.rawValue) else {
            return ImageStore.instance.getCGImage(imageName: "user_default" + size.rawValue)!
        }
        return cgImage
    }
    
    func findUsers<PropertyType: Equatable>(_ searchFor: PropertyType, _ keyPath: KeyPath<BasicUserData, PropertyType>) -> Array<BasicUserData> {
        // Anything that matches searchFor
        var matchedSearch: Array<BasicUserData> = []
        
        // Inefficient fix later, maybe we should sort the array first but that might slow things down further unless we just keep an array of sorted references
        for basicUser in publicUserData {
            if basicUser[keyPath: keyPath] == searchFor {
                matchedSearch.append(basicUser)
            }
        }
        return matchedSearch
    }
    
}


