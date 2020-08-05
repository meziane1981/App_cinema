//
//  UserData.swift
//  App_cinema
//
//  Created by Henry Franceschi on 04/08/2020.
//  Copyright © 2020 William Paparone. All rights reserved.
//

import SwiftUI


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
    }
    
    func findUsers<PropertyType: Equatable>(_ searchFor: PropertyType, _ keyPath: KeyPath<BasicUserData, PropertyType>) -> Array<BasicUserData> {
        var matchedSearch: Array<BasicUserData> = []
        
        for basicUser in publicUserData {
            if basicUser[keyPath: keyPath] == searchFor {
                matchedSearch.append(basicUser)
            }
        }
        return matchedSearch
    }
    
}


