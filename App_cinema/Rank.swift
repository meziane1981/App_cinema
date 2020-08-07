//
//  Rank.swift
//  App_cinema
//
//  Created by John Maddalena on 06/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

struct DataUser: Identifiable {
    
    var id = UUID()
    let name: String
    let lastname: String
    let nickname: String
    let pointToday: Int
    let pointWeek: Int
    let pointMonth: Int
}

struct RankView: View {
    
    
    @State var pickerSelection = 0
    var selectedSortedArray: [DataUser]{
        switch pickerSelection {
        case 0:
            return sortedArrayToday
        case 1:
            return sortedArrayWeek
        case 2:
            return sortedArrayMonth
        default:
            return sortedArrayToday
        }
    }
    
    var users: [BasicUserData]
    //    /////////////////////////////////
    
    
    let sortedArrayToday: [DataUser]
    let sortedArrayWeek: [DataUser]
    let sortedArrayMonth: [DataUser]
    
    var array: [DataUser] = [
        DataUser(name: "john", lastname: "doe", nickname: "JD", pointToday: 1200, pointWeek: 5008, pointMonth: 7000),
        DataUser(name: "henry", lastname: "bbb", nickname: "HB", pointToday: 1345, pointWeek: 2690, pointMonth: 12000),
        DataUser(name: "jean", lastname: "michel", nickname: "JM", pointToday: 900, pointWeek: 4560, pointMonth: 10000),
        DataUser(name: "lucie", lastname: "sa", nickname: "LS", pointToday: 2365, pointWeek: 3000, pointMonth: 9900),
        DataUser(name: "pascal", lastname: "lo", nickname: "PL", pointToday: 230, pointWeek: 3400, pointMonth: 14900),
        DataUser(name: "ho", lastname: "ho", nickname: "HH", pointToday: 895, pointWeek: 2900, pointMonth: 14000)
    ]
    
    init() {

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
                            UserTopRankProfileView(userData: self.selectedSortedArray[index], rank: index + 1)
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
                            UserRankProfileView(userData: self.selectedSortedArray[index], rank: index + 1)
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

