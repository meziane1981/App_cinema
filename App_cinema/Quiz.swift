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
    let Symbol: String
    
}

struct QuestionTestingView: View {
    var questions: [Question]
    @State private var response: Int? = nil
 
    @State private var bgColour: Color = Color.white
    @State private var primaryTextColor: Color = Color.gray
    @State private var secondaryTextColor: Color = Color.white
    
    var body: some View {
        ZStack {
            
            bgColour
            
            // The question
            Text("\(questions[0].text + "?")")
                .fontWeight(.semibold)
                .foregroundColor(primaryTextColor)
                .padding(20)
                .font(.title)
            
            // The answers
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                
                // Top row
                ForEach(0..<questions[0].options.count) { index in
                    Button(action: {
                        self.submitAnswer(answerIndex: index)
                    }) {
                        HStack {
                            Image(systemName: "circle.fill")
                            Text(self.questions[0].options[index])
                        }
                    
                    }.buttonStyle(QuizButtonStyle(fgColor: self.secondaryTextColor, bgColor: self.primaryTextColor))
                    
                }.padding(2.5)
            }
            
        }.foregroundColor(secondaryTextColor)
            .edgesIgnoringSafeArea(.all)
    }
    
    func submitAnswer(answerIndex: Int) {
        if answerIndex == self.questions[0].correctAnswer.rawValue {
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
        QuestionTestingView(questions: GameManager.getInstance().questions)
    }
}
