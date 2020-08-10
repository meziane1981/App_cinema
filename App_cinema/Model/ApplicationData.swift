//
//  UserData.swift
//  App_cinema
//
//  Created by Henry Franceschi on 04/08/2020.
//  Copyright © 2020 William Paparone. All rights reserved.
//

import SwiftUI

final class GameManager {
    private var currentUserID: Int
    private var userData: [UserData]
    var publicUserData: [BasicUserData]
    var questions: [Question]
    
    public private(set) static var instance = GameManager(userFile: "UserDataGenerated", quizFile: "QuizData")
    
//    static func getInstance() -> GameManager {
//        return Self.instance
//    }
    
    private init(userFile: String, quizFile: String) {
        self.userData = loadJSON(userFile)
        self.publicUserData = self.userData.map {
            BasicUserData(id: $0.id, nickName: $0.nickName, image: $0.image, firstName: $0.firstName, lastName: $0.lastName, gender: $0.gender.self)
        }
        self.questions = loadJSON(quizFile)
        
            // For permissions
        self.currentUserID = userData[0].id
        }
        
    func requestUserDetails(_ id: Int) -> Optional<UserData> {
        for user in userData {
            if user.id == id || user.friends.contains(id) {
                return user
            }
        }
        return nil
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


