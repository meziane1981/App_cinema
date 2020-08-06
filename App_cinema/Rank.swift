//
//  Rank.swift
//  App_cinema
//
//  Created by John Maddalena on 06/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

prefix operator ⋮
prefix func ⋮(hex:UInt32) -> Color {
    return Color(hex)
}

extension Color {
    init(_ hex: UInt32, opacity:Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

let hexColor:(UInt32) -> (Color) = {
    return Color($0)
}

struct RankView: View {
    
    var users: [BasicUserData]
    
    @State var pickerSelection = 0
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .blue
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        self.users = GameManager.getInstance().publicUserData
    }
    
    
    var body: some View {
        VStack {
            VStack {
                Text("Classement")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .fontWeight(.heavy)
                Picker(selection: $pickerSelection, label: Text("rank")) {
                    Text("Today").tag(0)
                    Text("Week").tag(1)
                    Text("Month").tag(2)
                }
                .padding()
                .pickerStyle(SegmentedPickerStyle())
                
                HStack {
                    ForEach(0...2, id: \.self) { index in
                        VStack {
                            UserProfilePreview(userData: self.users[index])
                                .padding(.leading, 10)
                                .padding(.trailing, 10)
                        }
                    }
                }
                .padding(.top, 40)
                .padding(.bottom, 40)
                .background(Color.white)
            }
            
            Spacer()
            ScrollView {
                VStack {
                    ForEach(users) { user in
                        HStack {
                            UserProfilePreview(userData: user)
                            Text("score")
                        }
                        .padding()
                        .frame(width: 250.0, height: 80.0)
                        .background(Color.white)
                        .cornerRadius(50)
                    }
                }
                Spacer()
            }
            
        }
        .background(Color(0x041353))
    }
}


struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        RankView()
    }
}

