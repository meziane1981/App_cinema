//
//  Quiz.swift
//  App_cinema
//
//  Created by Henry Franceschi on 05/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI
import Foundation

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

struct GameView: View {
    // Now only a single question, will create a parent view called game that will handle this
    @ObservedObject var quizViewModel: QuizViewModel
    
    //Timer for game
    @State private var timeRemaining = 20
    @State private var isActive = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var gameIsEnded = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                //            bgColour
                LinearGradient(Color.darkStart, Color.darkEnd)
                
                NavigationLink(destination: EndGameView(quizViewModel: QuizViewModel()), isActive: $gameIsEnded) {
                    Text("")
                }
                // The answers
                VStack(alignment: .center, spacing: 40) {
                    VStack {
                        Text("Time: \(timeRemaining)")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    
                    
                    HStack(spacing: 100) {
                        Text("Questions: \n\t\(self.quizViewModel.currentIndex + 1) / \(self.quizViewModel.questions.count)")
                        Text("Points: \n\t\(self.quizViewModel.point)")
                    }
                    // The question
                    
                    Text("\(quizViewModel.questions[quizViewModel.currentIndex].questionText + "?")")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(40)
                        .font(.title)
                    
                    ForEach(0..<quizViewModel.questions[quizViewModel.currentIndex].possibleAnswers.count) { index in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                self.quizViewModel.response = index
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    self.quizViewModel.nextQuestion()
                                }
                            }
                        }) {
                            Text(self.quizViewModel.questions[self.quizViewModel.currentIndex].possibleAnswers[index])
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(ButtonBackground(isCorrectResponse: self.quizViewModel.response == self.quizViewModel.questions[self.quizViewModel.currentIndex].correctAnswer, isHightlighted: self.quizViewModel.response == index, shape: RoundedRectangle(cornerRadius: 15)))
                            
                        }
                        .disabled(self.quizViewModel.response == nil ? false : true)
                    }
                    .padding(.horizontal, 25)
                }
            }
            .foregroundColor(.white)
            .edgesIgnoringSafeArea(.all)
        }
        .onReceive(timer) { time in
            guard self.isActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer.upstream.connect().cancel()
                self.gameIsEnded = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) {
            _ in
            self.isActive = true
        }
    }
}

struct EndGameView: View {
    @ObservedObject var quizViewModel: QuizViewModel
    
    var body: some View {
        ZStack {
            //            bgColour
            if self.quizViewModel.point < 500 {
                LinearGradient(Color.redStart, Color.redEnd)
            } else {
                LinearGradient(Color.greenStart, Color.greenEnd)
            }
            
            Text("Hello world")
                .foregroundColor(.white)
            
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
    }
}

struct Quiz_Previews: PreviewProvider {
    static var previews: some View {
        GameView(quizViewModel: QuizViewModel())
    }
}


