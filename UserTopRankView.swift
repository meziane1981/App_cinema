//
//  UserTopRankView.swift
//  App_cinema
//
//  Created by John Maddalena on 06/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

struct UserTopRankProfileView: View {
    var userData: BasicUserData
    var rank: Int
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 50, weight: .regular))
                Text(userData.userName)
                Text("#\(userData.id)")
                    .font(.caption)
                    .fontWeight(.thin)
                Text("score")
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
