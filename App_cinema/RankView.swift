//
//  Rank.swift
//  App_cinema
//
//  Created by John Maddalena on 06/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

struct RankView: View {
    
    @State var pickerSelection = 0
    var selectedSortedArray: [UserData] {
        switch pickerSelection {
        case 0 :
            return self.sortedArrayToday
        case 1:
            return self.sortedArrayWeek
        case 2 :
            return self.sortedArrayMonth
        default :
            return self.sortedArrayToday
        }
    }
    
    var selectedSortRank: Statistics.RankScoreByTime {
        switch pickerSelection {
        case 0 :
            return .day
        case 1:
            return .week
        case 2 :
            return .month
        default :
            return .day
        }
    }
    
    var users: [UserData] = loadJSON("UserDataGenerated")
    
    let sortedArrayToday: [UserData]
    let sortedArrayWeek: [UserData]
    let sortedArrayMonth: [UserData]
    
    init() {
        sortedArrayToday = users.sorted
            {$0.statistics.scoreSum(days: Statistics.RankScoreByTime.day) > $1.statistics.scoreSum(days: Statistics.RankScoreByTime.day)}
        sortedArrayWeek = users.sorted
            {$0.statistics.scoreSum(days: Statistics.RankScoreByTime.week) > $1.statistics.scoreSum(days: Statistics.RankScoreByTime.week)}
        sortedArrayMonth = users.sorted
            {$0.statistics.scoreSum(days: Statistics.RankScoreByTime.month) > $1.statistics.scoreSum(days: Statistics.RankScoreByTime.month)}
    }
    
    var body: some View {
        ZStack{
            LinearGradient(Color.darkBlueEnd, Color.darkBlueStart).edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    Text("Classement")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .fontWeight(.heavy)
                    Picker(selection: $pickerSelection, label: Text("rank")) {
                        Text("JOUR").tag(0)
                        Text("SEMAINE").tag(1)
                        Text("MOIS").tag(2)
                    }
                    .padding()
                    .pickerStyle(SegmentedPickerStyle())
                    
                    HStack {
                        ForEach(0...2, id: \.self) { index in
                            UserTopRankProfileView(userData: self.selectedSortedArray[index], rankScoreByTime: self.selectedSortRank,  rank: index + 1)
                        }
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity)
                    .border(Color.blue)
                    .background(Color.white)
                    .cornerRadius(50)
                    .shadow(color: Color("3779F4"), radius: 25)
                }
                Spacer()
                ScrollView {
                    Spacer()
                    VStack(alignment: .leading) {
                        ForEach(3..<50, id: \.self) { index in
                            UserRankProfileView(userData: self.selectedSortedArray[index], rankScoreByTime: self.selectedSortRank, rank: index + 1)
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

