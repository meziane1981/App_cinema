//
//  Quiz.swift
//  App_cinema
//
//  Created by Henry Franceschi on 10/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

struct Question: Codable, Identifiable {
    var id: String
    var questionText: String
    var image: String
    var correctAnswer: Int
    var possibleAnswers: [String]
}
