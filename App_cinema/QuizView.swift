//
//  Quiz.swift
//  App_cinema
//
//  Created by Henry Franceschi on 05/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

struct ButtonBackground<S: Shape>: View {

    var isCorrectResponse: Bool
    
    var gradientCorrect = LinearGradient( Color.green, Color.blue)
    var gradientIncorrect = LinearGradient( Color.pink, Color.red)

    
    var isHightlighted: Bool
    var shape: S
    
    var body: some View {
        ZStack {
            
            if isHightlighted {
                shape
                    .fill(LinearGradient(Color.darkEnd, Color.darkStart))
                    .overlay(shape.stroke(isCorrectResponse ? gradientCorrect : gradientIncorrect))
                    .shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
                    .shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(Color.darkEnd, lineWidth: 2))
                    .shadow(color: Color.darkStart.opacity(0.5), radius: 10, x: -10, y: -10)
                    .shadow(color: Color.darkEnd.opacity(0.5), radius: 10, x: 10, y: 10)
            }
        }
    }
}

struct QuestionTestingView: View {
    // Now only a single question, will create a parent view called game that will handle this
    var question: Question
    @State private var response: Int? = nil
    
    var body: some View {
        ZStack {
//            bgColour
            LinearGradient(Color.darkStart, Color.darkEnd)

            // The answers
            VStack(alignment: .center, spacing: 40) {
                // The question
                Text("\(question.questionText + "?")")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(40)
                    .font(.title)
                
                ForEach(0..<question.possibleAnswers.count) { index in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.response = index
                        }
                    }) {
                        Text(self.question.possibleAnswers[index])
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(ButtonBackground(isCorrectResponse: self.response == self.question.correctAnswer, isHightlighted: self.response == index, shape: RoundedRectangle(cornerRadius: 15)))
                    
                    }
                    .disabled(self.response == nil ? false : true)
                }
                .padding(.horizontal, 25)
            }
        }
        .foregroundColor(.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct Quiz_Previews: PreviewProvider {
    static var previews: some View {
        QuestionTestingView(question: GameManager.instance.questions[0])
    }
}


