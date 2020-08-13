//
//  ContentView.swift
//  App_cinema
//
//  Created by William Paparone on 03/08/2020.
//  Copyright © 2020 William Paparone. All rights reserved.
//

import SwiftUI

struct RootView: View {
    
    @State var index = 0
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if self.index == 0{
                    NavigationView {
                        HomeView()
                    }
                    // HomeView()
                } else if self.index == 1{
                    
                    NavigationView {
                        ProfileView(profileVM: ProfileViewModel(userID: GameManager.instance.currentUser.id))
                        
                    }
                    
                } else if self.index == 2{
                    ShopView()
                } else {
                    RankView()
                }
            }
            CircleTab(index: self.$index)
        }
    }
}
// TEST
struct CircleTab: View {
    
    @Binding var index: Int
    
    var body: some View {
        HStack {
            
            Button(action: {
                self.index = 0
            }) {
                VStack {
                    if self.index != 0{
                        Image(systemName: "gamecontroller").foregroundColor(Color.black.opacity(0.2))
                    } else {
                        Image(systemName: "gamecontroller")
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color("3779F4"))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.2), radius: 10, x: -5, y: -5)
                            .offset(y: -20)
                            .padding(.bottom, -20)
                        
                        Text("Quiz").foregroundColor(Color.black.opacity(0.7))
                    }
                }
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                self.index = 1
            }) {
                VStack {
                    if self.index != 1{
                        Image(systemName: "person").foregroundColor(Color.black.opacity(0.2))
                    } else {
                        Image(systemName: "person")
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color("3779F4"))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.2), radius: 10, x: -5, y: -5)
                            .offset(y: -20)
                            .padding(.bottom, -20)
                        
                        Text("Profile").foregroundColor(Color.black.opacity(0.7))
                    }
                }
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                self.index = 2
            }) {
                VStack {
                    if self.index != 2{
                        Image(systemName: "film").foregroundColor(Color.black.opacity(0.2))
                    } else {
                        Image(systemName: "film")
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color("3779F4"))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.2), radius: 10, x: -5, y: -5)
                            .offset(y: -20)
                            .padding(.bottom, -20)
                        
                        Text("Shop").foregroundColor(Color.black.opacity(0.7))
                    }
                }
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                self.index = 3
            }) {
                VStack {
                    if self.index != 3{
                        Image(systemName: "rosette").foregroundColor(Color.black.opacity(0.2))
                    } else {
                        Image(systemName: "rosette")
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color("3779F4"))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.2), radius: 10, x: -5, y: -5)
                            .offset(y: -20)
                            .padding(.bottom, -20)
                        
                        Text("Rank").foregroundColor(Color.black.opacity(0.7))
                    }
                }
            }
        }
        .padding(.vertical, -10)
        .padding(.horizontal, 25)
        .background(Color.white)
        .animation(.spring())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
