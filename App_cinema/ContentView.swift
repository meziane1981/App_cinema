//
//  ContentView.swift
//  App_cinema
//
//  Created by William Paparone on 03/08/2020.
//  Copyright © 2020 William Paparone. All rights reserved.
//

import SwiftUI

struct UserExampleView: View {
    var userData: BasicUserData
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle.fill")
                HStack(alignment: .center, spacing: 0) {
                    Text(userData.userName)
                    Text("(#\(userData.id))")
                        .font(.caption)
                        .fontWeight(.thin)
                }

            }
            
            HStack() {
                Text("\(userData.firstName) \(userData.lastName)(\(userData.gender.rawValue == Gender.male.rawValue ? "m" : "f"))")
            }
        }
//            Text(userData.profileDescription)
    }
}



struct ContentView: View {
    //
    @State var users: [BasicUserData] = GameManager.getInstance().findUsers("Tim", \.firstName)
    @State var searchingSelection: Int = 0
    
    @State var searchStr: String = ""
    
//    var questions = GameManager.getInstance().questions
    var body: some View {
        
        VStack {
            
            HStack {
                TextField("search for user", text: $searchStr)
                
                Button(action: {
                    print("searching")
                }) {
                    Image(systemName: "magnifyingglass.circle.fill")
                }
            }.padding(20)
            
            ForEach(users) {
                UserExampleView(userData: $0)
            }
//            Text("Everything is under control, don't panic!")
//                .padding(.bottom, 50)
//            UserExampleView(userData: users[0])
            
//            QuestionTestingView(question: questions)
            
            
        }
        
//        VStack {
//            ForEach(userData, id: \.id) { uData in
//                UserExampleView(userData: uData)
//            }
//            Text(userDataJSON)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
