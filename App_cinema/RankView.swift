//
//  Rank.swift
//  App_cinema
//
//  Created by John Maddalena on 06/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

//struct DataUser: Identifiable {
//
//    var id = UUID()
//    let name: String
//    let lastname: String
//    let nickname: String
//    let pointToday: Int
//    let pointWeek: Int
//    let pointMonth: Int
//}

struct RankView: View {
    
    
    @State var pickerSelection = 0
    var selectedSortedArray: [UserData]{
        switch pickerSelection {
        case 0:
            return sortedArrayToday
       case 1:
            return sortedArrayToday
        case 2:
            return sortedArrayToday
        default:
            return sortedArrayToday
        }
    }
    
    var users: [UserData] = loadJSON("UserDataGenerated")
    
    let sortedArrayToday: [UserData]
    
    init() {
        sortedArrayToday = users.sorted
            {$0.statistics.pointsLast30Days[0] > $1.statistics.pointsLast30Days[0]}
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
                            UserTopRankProfileView(userData: self.selectedSortedArray[index], rankScoreByTime: RankScoreByTime(rawValue: 30), rank: index + 1)
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
                            UserRankProfileView(userData: self.selectedSortedArray[index], rankScoreByTime: RankScoreByTime(rawValue: 30), rank: index + 1)
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

