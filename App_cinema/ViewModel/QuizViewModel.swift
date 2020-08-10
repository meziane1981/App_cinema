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
    
    init() {
        self.questions = loadJSON("QuizData")
    }
}
