//
//  ContentView.swift
//  App_cinema
//
//  Created by William Paparone on 03/08/2020.
//  Copyright © 2020 William Paparone. All rights reserved.
//

import SwiftUI

struct RootView: View {
    @State private var selectedTab: Int = 1
    var body: some View {
        VStack {
            // Text("Everything is under control, don't panic!")
            TabView(selection: $selectedTab) {
                VStack {
                    Image(systemName: "clock")
                }.tabItem {
                    VStack {
                        Image(systemName: selectedTab == 1 ? "gamecontroller.fill" : "gamecontroller")
                        Text("Game")
                    }
                }.tag(1)
                
                VStack{
                    Profile()
                }.tabItem {
                    VStack {
                        Image(systemName: selectedTab == 2 ? "person.fill" : "person")
                        Text("Profiles")
                    }
                }.tag(2)
                
                VStack{
                    Text("Test3")
                }.tabItem {
                    VStack {
                        Image(systemName: selectedTab == 3 ? "cart.fill" : "cart")
                        Text("Rewards")
                    }
                }.tag(3)
                
                VStack{
                    Text("Rank View")
                }.tabItem {
                    VStack {
                        Image(systemName: selectedTab == 4 ? "arrow.up.arrow.down.circle.fill" : "arrow.up.arrow.down.circle")
                        Text("Ranking")
                    }
                }.tag(4)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
