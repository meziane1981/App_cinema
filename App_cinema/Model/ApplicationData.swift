//
//  UserData.swift
//  App_cinema
//
//  Created by Henry Franceschi on 04/08/2020.
//  Copyright © 2020 William Paparone. All rights reserved.
//

import SwiftUI

struct UserData: Codable, Identifiable {
    var id: Int
    var username: String
    var profileDescription: String
    var firstName: String
    var lastName: String
    var image: String
    var isOnline: Bool
}

struct Question: Codable, Identifiable {
    var id: String
    var text: String
    var image: String
    var correctAnswer: Int
    var options: [String]
}

final class GameManager {
    var userData: [UserData]
    var questions: [Question]
    
    private static var instance = GameManager(userFile: "UserData", quizFile: "QuizData")
    
    func getInstance() -> GameManager {
        return Self.instance
    }
    
    private init(userFile: String, quizFile: String) {
        self.userData = loadJSON(userFile)
        self.questions = loadJSON(quizFile)
    }
    
    
}


