//
//  ContentView.swift
//  App_cinema
//
//  Created by William Paparone on 03/08/2020.
//  Copyright © 2020 William Paparone. All rights reserved.
//

import SwiftUI

struct UserExampleView: View {
    var userData: UserData
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle.fill")
                HStack(alignment: .center, spacing: 0) {
                    Text(userData.username)
                    Text("(\(userData.id))")
                        .font(.caption)
                        .fontWeight(.thin)
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            ForEach(userData, id: \.id) { uData in
                UserExampleView(userData: uData)
            }
            Text(userDataJSON)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
