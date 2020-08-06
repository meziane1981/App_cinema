//
//  UserRankProfileView.swift
//  App_cinema
//
//  Created by John Maddalena on 06/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

struct UserRankProfileView: View {
    var userData: BasicUserData
    var rank: Int
    
    var body: some View {
        HStack {
            Text("\(rank)")
                .foregroundColor(Color.white)
                .fontWeight(.heavy)
                .padding(.leading, 40)
                .padding(.trailing, 20)
            HStack{
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 50, weight: .regular))
                VStack(alignment: .leading) {
                    Text(userData.userName)
                    Text("#\(userData.id)")
                        .font(.caption)
                        .fontWeight(.thin)
                }
                Spacer()
                Text("Score")
                    .fontWeight(.heavy)
                    .font(.title)
                .frame(alignment: .trailing)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(50)
        }
        .padding(.trailing, 40)
    }
}
