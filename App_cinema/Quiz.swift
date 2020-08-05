//
//  Quiz.swift
//  App_cinema
//
//  Created by Henry Franceschi on 05/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

struct QuizButtonStyle: ButtonStyle {
    var fgColor: Color
    var bgColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(fgColor)
            .padding()
            .background(bgColor)
            .cornerRadius(10)
    }
}

struct ButtonData {
    let pushValue: Int
    
}

struct QuestionTestingView: View {
    var question: [Question]
    @State private var response: Int? = nil
 
    @State private var bgColour: Color = Color.white
    @State private var primaryTextColor: Color = Color.gray
    @State private var secondaryTextColor: Color = Color.white
    
    var body: some View {
        ZStack {
            
            bgColour
            
            // The question
            Text("\(question[0].text + "?")")
                .fontWeight(.semibold)
                .foregroundColor(primaryTextColor)
                .padding(20)
                .font(.title)
            
            // The answers
            VStack(alignment: .center, spacing: 0) {
                Spacer(minLength: 690)
                
                // Top row
                HStack {
                    Button(action: {
                        self.submitAnswer(answerIndex: 0)
                    }) {
                        HStack {
                            Image(systemName: "a.circle.fill")
                            Text(question[0].options[0])
                                .font(.subheadline)
                                .frame(width: 120, height: 30)
                        }
                    }
                    .buttonStyle(QuizButtonStyle(fgColor: secondaryTextColor, bgColor: primaryTextColor))
                    
                    Spacer()
                    
                    Button(action: {
                        self.submitAnswer(answerIndex: 1)
                    }) {
                        HStack {
                            Image(systemName: "b.circle.fill")
                            Text(question[0].options[1])
                                .font(.subheadline)
                                .frame(width: 120, height: 30)
                        }
                    }
                    .buttonStyle(QuizButtonStyle(fgColor: secondaryTextColor, bgColor: primaryTextColor))
                    
                }
                .padding(20)
                
                // Bottom row
                HStack {
                    Button(action: {
                        self.submitAnswer(answerIndex: 2)
                    }) {
                        HStack {
                            Image(systemName: "c.circle.fill")
                            Text(question[0].options[2])
                                .font(.subheadline)
                                .frame(width: 120, height: 30)
                        }
                    }
                    .buttonStyle(QuizButtonStyle(fgColor: secondaryTextColor, bgColor: primaryTextColor))
                    
                    Spacer()
                    
                    Button(action: {
                        self.submitAnswer(answerIndex: 3)
                    }) {
                        HStack {
                            Image(systemName: "d.circle.fill")
                            Text(question[0].options[3])
                                .font(.subheadline)
                                .frame(width: 120, height: 30)
                        }
                    }
                    .buttonStyle(QuizButtonStyle(fgColor: secondaryTextColor, bgColor: primaryTextColor))
                }
                .padding(20)
                
                Spacer()
            }
            
        }.foregroundColor(secondaryTextColor)
            .edgesIgnoringSafeArea(.all)
    }
    
    func submitAnswer(answerIndex: Int) {
        if answerIndex == self.question[0].correctAnswer.rawValue {
            // Do something
            self.bgColour = Color.green
            self.primaryTextColor = Color.white
            self.secondaryTextColor = Color.black
        }
        else {
            self.bgColour = Color.red
            self.primaryTextColor = Color.white
            self.secondaryTextColor = Color.black
        }
    }
}

struct Quiz_Previews: PreviewProvider {
    static var previews: some View {
        QuestionTestingView(question: GameManager.getInstance().questions)
    }
}
