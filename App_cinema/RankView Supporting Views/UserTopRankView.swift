//
//  UserTopRankView.swift
//  App_cinema
//
//  Created by John Maddalena on 06/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

struct UserTopRankProfileView: View {
    var userData: UserData
    var rankScoreByTime: Statistics.RankScoreByTime
    var rank: Int
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Image(GameManager.instance.fetchUserImage(imageName: userData.profileImageName, size: ImageSize.small), scale: 1, label: Text("Top Ranked User Profile Image"))
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                
                Text(userData.nickName)
                Text("#\(userData.id)")
                    .font(.caption)
                    .fontWeight(.thin)
                Text("\(userData.statistics.scoreSum(days: rankScoreByTime))")
                    .fontWeight(.heavy)
                    .font(.headline)
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)
            Spacer()
                .frame(height: 20)
            Text("\(rank)")
                .fontWeight(.heavy)
        }
    }
}
