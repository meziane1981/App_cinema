//
//  QuizViewModel.swift
//  App_cinema
//
//  Created by Henry Franceschi on 10/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI


final class QuizViewModel: ObservableObject {
    // Manages the state of the quiz
    // Questions array
    public private(set) var questions: [Question]
    // Number of questions
    // Current question
    @Published var currentIndex: Int
    @Published var response: Int? = nil {
        didSet {
            if questions[currentIndex].correctAnswer == response {
                increasePoint()
            }
        }
    }
    //points
    @Published var point: Int
    
    init() {
        self.questions = loadJSON("QuizData")
        self.currentIndex = 0
        self.point = 0
    }
    
    func nextQuestion() {
        self.currentIndex+=1
        self.response = nil
        
    }
    
    func increasePoint() {
        self.point += 100
    }
}
