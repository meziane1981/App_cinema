//
//  Rank.swift
//  App_cinema
//
//  Created by John Maddalena on 06/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

struct RankView: View {
    
    var users: [BasicUserData]
    @State var pickerSelection = 0
    init() {
        self.users = GameManager.instance.publicUserData
    }
    
    var body: some View {
        ZStack{
            Color("041353").edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    Text("Classement")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .fontWeight(.heavy)
                    Picker(selection: $pickerSelection, label: Text("rank")) {
                        Text("TODAY").tag(0)
                        Text("WEEK").tag(1)
                        Text("MONTH").tag(2)
                    }
                    .padding()
                    .pickerStyle(SegmentedPickerStyle())
                    HStack {
                        ForEach(0...2, id: \.self) { index in
                            UserTopRankProfileView(userData: self.users[index], rank: index + 1)
                        }
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(50)
                    .shadow(color: Color("3779F4"), radius: 25)
                }
                Spacer()
                ScrollView {
                    Spacer()
                    VStack(alignment: .leading) {
                        ForEach(3..<50, id: \.self) { index in
                            UserRankProfileView(userData: self.users[index], rank: index + 1)
                        }
                    }
                }
            }
        }
    }
}


struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        RankView()
    }
}

