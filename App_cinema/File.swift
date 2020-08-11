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
                   // HomeView()
                } else if self.index == 1{
                    Profile()
                } else if self.index == 2{
                   // ShopView()
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
                        Image("home-icon").foregroundColor(Color.black.opacity(0.2))
                    } else {
                        Image("home-icon")
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color("3779F4"))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.2), radius: 10, x: -5, y: -5)
                            .offset(y: -20)
                            .padding(.bottom, -20)
                        
                        Text("Home").foregroundColor(Color.black.opacity(0.7))
                    }
                }
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                self.index = 1
            }) {
                VStack {
                    if self.index != 1{
                        Image("profil-icon").foregroundColor(Color.black.opacity(0.2))
                    } else {
                        Image("profil-icon")
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
                        Image("shop-icon").foregroundColor(Color.black.opacity(0.2))
                    } else {
                        Image("shop-icon")
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
                        Image("rank-icon").foregroundColor(Color.black.opacity(0.2))
                    } else {
                        Image("rank-icon")
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
