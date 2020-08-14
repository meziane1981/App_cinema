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

struct TimerBackground<S: Shape>: View {
    var shape: S
    
    var body: some View {
        ZStack {
            shape
                .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                .shadow(color: Color.darkStart.opacity(0.5), radius: 10, x: -10, y: -10)
                .shadow(color: Color.darkEnd.opacity(0.5), radius: 10, x: 10, y: 10)
        }
    }
}

struct ProgressBar: View {
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5.0)
                .foregroundColor(.red)
            Circle()
                .trim(from: 0.0, to: CGFloat(self.progress))
                .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(.orange)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.easeInOut(duration: 0.1))
        }
    }
}

struct GameView: View {
    // Now only a single question, will create a parent view called game that will handle this
    @ObservedObject var quizViewModel: QuizViewModel
    
    //Timer for game
    @State private var timeRemaining: Float = 60
    @State private var isActive = true
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    
    //progress bar
    @State var progresValue: Float = 1
    var startTime: Float = 60
    
    var body: some View {
        NavigationView {
            ZStack {
                //            bgColour
                LinearGradient(Color.darkStart, Color.darkEnd)
                
                NavigationLink(destination: EndGameView(quizViewModel: quizViewModel), isActive: $quizViewModel.gameIsEnded) {
                    Text("")
                }
                // The answers
                VStack(alignment: .center, spacing: 40) {
                    
                    
                    HStack(spacing: 60) {
                        Text("Questions: \n\t\(self.quizViewModel.currentIndex + 1) / \(self.quizViewModel.questions.count)")
                        Text("Points: \n\t\(self.quizViewModel.point)")
                        
                        ZStack {
                            Text("\(String(format: "%.f", timeRemaining))")
                                //.font(.largeTitle)
                                .foregroundColor(.white)
                            ProgressBar(progress: self.$progresValue)
                                .frame(width: 50.0, height: 50.0)
                                .padding(10.0)
                        }
                        .background(TimerBackground(shape: Circle()))
                    }
                    // The question
                    Text("\(quizViewModel.questions[quizViewModel.currentIndex].questionText)")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(20)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    
                    Image(quizViewModel.questions[quizViewModel.currentIndex].image)
                    .resizable()
                        .frame(height: 250)
//                    .aspectRatio(contentMode: )
                    
                    // The buttons
                    ForEach(0..<quizViewModel.questions[quizViewModel.currentIndex].possibleAnswers.count) { index in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                self.quizViewModel.response = index
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    self.quizViewModel.nextQuestion()
                                }
                            }
                        }) {
                            Text(self.quizViewModel.questions[self.quizViewModel.currentIndex].possibleAnswers[index])
                                .frame(maxWidth: .infinity)
                                .background(ButtonBackground(isCorrectResponse: self.quizViewModel.response == self.quizViewModel.questions[self.quizViewModel.currentIndex].correctAnswer, isHightlighted: self.quizViewModel.response == index, shape: RoundedRectangle(cornerRadius: 15)))
                            
                        }
                        .disabled(self.quizViewModel.response == nil ? false : true)
                    }
                    .padding(.horizontal, 25)
                }
            }
                
            
            .navigationBarHidden(true)
            .foregroundColor(.white)
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
        .onReceive(timer) { time in
            guard self.isActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 0.01
                self.progresValue = self.timeRemaining / self.startTime
            } else {
                self.timer.upstream.connect().cancel()
                self.quizViewModel.gameIsEnded = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) {
            _ in
            self.isActive = true
        }
            // Otherwise it will just continue even when we move to another screen
//        .onDisappear {
//            self.timer.upstream.connect().cancel()
//        }
    }
}

struct EndGameView: View {
    @ObservedObject var quizViewModel: QuizViewModel
    
    var body: some View {
        ZStack {
            
            if self.quizViewModel.point < 500 {
                //            bgColour
                LinearGradient(Color.darkBlueStart, Color.darkBlueEnd)
                
                VStack(spacing: 100) {
                    Text("Vous avez Gagné")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    Text("Vous avez répondu à \(self.quizViewModel.numCorrectAnswers) / \(self.quizViewModel.questions.count) questions")
                        .foregroundColor(.white)
                    Text("Félicitation vous avez gagné \(self.quizViewModel.point) points")
                        .foregroundColor(.white)
                }
            } else {
                //            bgColour
                LinearGradient(Color.darkBlueStart, Color.darkBlueEnd)
                
                VStack(spacing: 100) {
                    Text("Vous avez Gagné")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    Text("Vous avez répondu à \(self.quizViewModel.numCorrectAnswers) / \(self.quizViewModel.questions.count) questions")
                        .foregroundColor(.white)
                    Text("Félicitation vous avez gagné \(self.quizViewModel.point) points")
                        .foregroundColor(.white)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

struct Quiz_Previews: PreviewProvider {
    static var previews: some View {
        GameView(quizViewModel: QuizViewModel())
    }
}


