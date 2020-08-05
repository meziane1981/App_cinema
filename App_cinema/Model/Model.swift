//
//  Model.swift
//  App_cinema
//
//  Created by William Paparone on 04/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import Foundation


//Profile screen
struct User: Identifiable {
    
    let id: Int
    let firstName: String
    let lastName: String
    var nickName: String
    var age: Int
    var image: String
    var date: Date
    var time: Double
    let rewards: [Reward]
    let statistics: [Statistic]
    var friends: [Int] // tableau d'ID
    
    mutating func addFriend() {
        self.friends.append(self.id)
    }
}

struct Reward: Identifiable {
    
    var id = UUID()
    let name: String
    let icon: String
    let price: Double
}

struct Shop {
    
    let rewards: [Reward]
    var coin: Int
}

struct Statistic {
    
    var points: Int
    var progression: Int
    
}

//ranked screen


//home screen


//game screen
struct Quizz: Identifiable {
    
    let id: Int
    let question: String
    let answer: String
    let time: Double
    let maxNumberOfQuestions: Int
    let correctAnswer: Int
    let image: String
}
