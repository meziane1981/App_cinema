//
//  HomeView.swift
//  App_cinema
//
//  Created by lucie besson on 11/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI


struct HomeButtonStyle: ButtonStyle {
    let colorStart: Color
    let colorEnd: Color
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(Color.darkBlueEnd, Color.darkBlueStart)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Image("mOvWie")
                        .padding(.bottom, 20.0)
                    
                    ZStack {
                        NavigationLink(destination: GameView(quizViewModel: QuizViewModel())) {
                            Text("Play")
                            .padding(20)
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.purple))
                        }
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
