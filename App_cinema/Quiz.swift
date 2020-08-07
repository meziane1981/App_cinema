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
            .cornerRadius(15)
    }
}

//struct ButtonData {
//    let Symbol: String
//    let label: String
//    let pushValue: Int
//
//
//}

struct QuizButton: View {
    @Binding var response: Int?
    
    let label: String
    let pushValue: Int
    
    // Style, parent is in charge of this
    let parentTextColor: Color
    let textColor: Color
    let bgColor: Color
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.response = self.pushValue
                
            }
        }) {
            Text(label)
                .frame(maxWidth: .infinity)
            
        }
        .disabled(response == nil ? false : true)
        .buttonStyle(QuizButtonStyle(fgColor: self.textColor, bgColor: self.parentTextColor.opacity(0.2)))
    }
}

struct QuestionTestingView: View {
    // Now only a single question, will create a parent view called game that will handle this
    var question: Question
    @State private var response: Int? = nil
    
    // Style
    @State private var gradientNeutral = [Color.orange, Color.purple]
    @State private var gradientCorrect = [Color.green, Color.blue]
    @State private var gradientIncorrect = [Color.pink, Color.red]
    
    @State private var bgColour: Color = Color.white
    @State private var primaryTextColor: Color = Color.white
    @State private var secondaryTextColor: Color = Color.white
    
    var body: some View {
        ZStack {
//            bgColour
            LinearGradient(gradient: Gradient(colors: gradientNeutral), startPoint:    .topLeading, endPoint: .bottomTrailing)
            LinearGradient(gradient: Gradient(colors: response == question.correctAnswer.rawValue ? gradientCorrect : gradientIncorrect), startPoint: .topLeading, endPoint: .bottomTrailing)
                .opacity(response == nil ? 0 : 1)
            
            
            // The question
            Text("\(question.text + "?")")
                .fontWeight(.semibold)
                .foregroundColor(primaryTextColor)
                .padding(40)
                .font(.title)
            
            // The answers
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                
                ForEach(0..<question.options.count) { index in
                    QuizButton(response: self.$response, label: self.question.options[index], pushValue: index, parentTextColor: self.primaryTextColor, textColor: self.secondaryTextColor, bgColor: .orange)
                    
                }.padding(2.5)
                .padding(5)
                    
            }.padding(.bottom, 10)
            
        }
        .foregroundColor(secondaryTextColor)
        .edgesIgnoringSafeArea(.all)
    }
    
//    func submitAnswer(answerIndex: Int) {
//        if answerIndex == self.questions[0].correctAnswer.rawValue {
//            // Do something
//            self.bgColour = Color.green
//            self.primaryTextColor = Color.white
//            self.secondaryTextColor = Color.black
//        }
//        else {
//            self.bgColour = Color.red
//            self.primaryTextColor = Color.white
//            self.secondaryTextColor = Color.black
//        }
//    }
}

struct Quiz_Previews: PreviewProvider {
    static var previews: some View {
        QuestionTestingView(question: GameManager.instance.questions[0])
    }
}


