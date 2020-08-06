//
//  UserData.swift
//  App_cinema
//
//  Created by Henry Franceschi on 04/08/2020.
//  Copyright © 2020 William Paparone. All rights reserved.
//

import SwiftUI

// User data
//var friendIDs: [Int] = [100003, 100007, 100009, 100012]
//var friends: [BasicUserData] = []
//
//for index in friendIDs {
//    GameManager.find
//}

enum Gender: String, Codable {
    case male, female
}

struct BasicUserData: Codable, Identifiable {
    var id: Int
    var userName: String
    var firstName: String
    var lastName: String
    var gender: Gender
}

struct UserData: Codable, Identifiable {
    var id: Int
    var userName: String
    var profileDescription: String
    var firstName: String
    var lastName: String
    var gender: Gender
    var age: Int
    var image: String
    var isOnline: Bool
}

struct Question: Codable, Identifiable {
    enum CorrectAnswer: Int, Codable {
        case answerA, answerB, answerC, answerD
    }
    
    var id: String
    var text: String
    var image: String
    var correctAnswer: CorrectAnswer
    var options: [String]
}

final class GameManager {
    private var currentUserID: Int
    private var userData: [UserData]
    var publicUserData: [BasicUserData]
    var questions: [Question]
    
    private static var instance = GameManager(userFile: "UserDataGenerated", quizFile: "QuizData")
    
    static func getInstance() -> GameManager {
        return Self.instance
    }
    
    private init(userFile: String, quizFile: String) {
        self.userData = loadJSON(userFile)
        self.publicUserData = self.userData.map {
            BasicUserData(id: $0.id, userName: $0.userName, firstName: $0.firstName, lastName: $0.lastName, gender: $0.gender.self)
        }
        self.questions = loadJSON(quizFile)
        
            // For permissions
        self.currentUserID = userData[0].id
        }
        
        
    
    
    // computed property that is the relevant info depending on whether the current user is friends with the other user
    // this will be removed only exists so we can test permission
    func requestUserDetails(_ id: Int) -> Optional<UserData> {
        for user in userData {
            if user.id == id {
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


