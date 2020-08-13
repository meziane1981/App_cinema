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
    @State var linkIsActive: Bool = false
    var body: some View {
        ZStack {
            LinearGradient(Color.darkBlueEnd, Color.darkBlueStart)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                
                LinearGradient(Color.purple, Color.pink)
                    .frame(width: 300, height: 100)
                    .mask(
                        GeometryReader { geometry in
                            Image("mOvWie")
                                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            
                        }
                    .shadow(color: Color.white.opacity(0.3), radius: 2, x: 5, y: 5)
                    .shadow(color: Color.white.opacity(0.3), radius: 2, x: -5, y: -5)
                )
                
                //                    GeometryReader { geometry in
                //                        Image("mOvWie")
                //                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                //
                //                    }
                
                ZStack {
                    NavigationLink(destination: GameView(quizViewModel: QuizViewModel()), isActive: self.$linkIsActive) {
                        
                        Button(action: {
                            self.linkIsActive = true
                        }) {
                            Text("PLAY !")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 43.0)
                        }
                        .buttonStyle(ShopButtonStyle(colorStart: Color(red: 0.5, green: 0.001, blue: 1.0), colorEnd: Color(hue: 0.75, saturation: 0.47, brightness: 0.874)) )
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
