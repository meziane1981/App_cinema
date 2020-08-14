//
//  ShopButtonView.swift
//  App_cinema
//
//  Created by lucie besson on 06/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

struct ShopBackground: View {
    var isHighlighted: Bool
    let colorStart: Color
    let colorEnd: Color

    var body: some View {
        ZStack {
            if isHighlighted {
                RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(colorEnd, colorStart))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(LinearGradient(Color.darkBlueStart, Color.darkBlueEnd), lineWidth: 4))
                .shadow(color: Color.darkBlueStart, radius: 10, x: 5, y: 5)
                .shadow(color: Color.darkBlueEnd, radius: 10, x: -5, y: -5)

            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(colorEnd, colorStart))
                    .shadow(color: Color.darkBlueStart, radius: 10, x: -10, y: -10)
                    .shadow(color: Color.darkBlueEnd, radius: 10, x: 10, y: 10)
            }
        }
    }
}

struct ShopButtonStyle: ButtonStyle {
    let colorStart: Color
    let colorEnd: Color
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(10)
            .contentShape(Circle())
            .background(
                ShopBackground(isHighlighted: configuration.isPressed, colorStart: colorStart, colorEnd: colorEnd)
            )
    }
}


struct ShopView: View {
        @State private var coins: Int = 300
        @State private var tickets: Int = 2
        @State private var popcorn: Int = 1
        @State private var drink: Int = 1
        @State private var drivin: Int = 1
        @State var alertCart: Bool = false
    
    var body: some View {
        
        ZStack {
            LinearGradient(Color.darkBlueEnd, Color.darkBlueStart)
                .edgesIgnoringSafeArea(.all)
            VStack {

                HStack {
                Image("icon_token_sm")
                .resizable()
                .frame(width: 30.0, height: 30.0)
                .padding(.leading, 250.0)
                    Text("\(Int(GameManager.instance.currentUser.statistics.coins)) jetons")
                    .font(.caption)
                    .foregroundColor(.white)
                }
                .padding(.top, 30.0)
                
                HStack {
                    Text("Boutique")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            
                HStack {
                    VStack {
                    Button(action: {
                        if  self.tickets > 0 {
                            self.tickets -= 2
                        } else {
                            self.alertCart = true
                        }
                    })
                    {
                        Image("icon_ticket")
                            .resizable()
                            .frame(width: 50.0, height: 60.0)
                            .padding(.horizontal, 5.0)
                    }
                    .buttonStyle(ShopButtonStyle(colorStart: .yellow, colorEnd: .red) )
                        
                        Text("\(Int(tickets)) places de cinéma")
                            .font(.caption)
                            .foregroundColor(Color.white)
                        HStack {
                        Image("icon_token_sm")
                        .resizable()
                            .frame(width: 15.0, height: 15.0)
                        Text("1300 jetons")
                        .font(.caption)
                        .foregroundColor(Color.white)
                        }
                    }
                    .padding()
                    
                    VStack {
                    Button(action: {
                        if  self.popcorn > 0 {
                            self.popcorn -= 1
                        } else {
                            self.alertCart = true
                        }
                    })
                    {
                        Image("icon_popcorn")
                            .resizable()
                            .frame(width: 50.0, height: 60.0)
                            .padding(.horizontal, 5.0)
                    }
                    .buttonStyle(ShopButtonStyle(colorStart: .pink, colorEnd: .purple) )
                        
                        Text("\(Int(popcorn)) popcorn")
                            .font(.caption)
                            .foregroundColor(Color.white)
                        HStack {
                        Image("icon_token_sm")
                        .resizable()
                        .frame(width: 15.0, height: 15.0)
                        Text("550 jetons")
                        .font(.caption)
                        .foregroundColor(Color.white)
                        }
                    }
                    .padding()
                    
                    VStack {
                    Button(action: {
                        if  self.drink > 0 {
                            self.drink -= 1
                            } else {
                                self.alertCart = true
                        }
                    })
                    {
                        Image("icon_drink")
                            .resizable()
                            .frame(width: 60.0, height: 60.0)
                    }
                    .buttonStyle(ShopButtonStyle(colorStart: .yellow, colorEnd: .orange) )
                        
                        Text("\(Int(drink)) boisson")
                            .font(.caption)
                            .foregroundColor(Color.white)
                        HStack {
                            Image("icon_token_sm")
                            .resizable()
                            .frame(width: 15.0, height: 15.0)
                        Text("300 jetons")
                        .font(.caption)
                        .foregroundColor(Color.white)
                        }
                    }
                    .padding()
                }
            
                HStack {
                    VStack {
                    Button(action: {
                        if  self.drivin > 0 {
                            self.drivin -= 1
                            
                            } else {
                                self.alertCart = true
                        }
                    }) {
                        Image("icon_vcamera")
                            .resizable()
                            .frame(width: 60.0, height: 50.0)
                            .padding(.vertical, 5.0)
                    }
                    .buttonStyle(ShopButtonStyle(colorStart: .white, colorEnd: .blue) )
                        
                        Text("\(Int(drivin)) évènement")
                        .font(.caption)
                        .foregroundColor(Color.white)
                        
                        HStack {
                        Image("icon_token_sm")
                        .resizable()
                        .frame(width: 15.0, height: 15.0)
                        
                        Text("1230 jetons")
                            .font(.caption)
                            .foregroundColor(Color.white)
                        }
                    }
                    .padding()
                    
                    VStack {
                    ZStack {
                        Button(action: {
                            if  self.coins > 0 {
                                self.coins -= 300
                                } else {
                                    self.alertCart = true
                            }
                        })
                        {
                            Image("icon_token_wh")
                                .resizable()
                                .frame(width: 60.0, height: 60.0)
                        }
                        .buttonStyle(ShopButtonStyle(colorStart: .pink, colorEnd: .white) )
                        .overlay(VStack {
                            HStack {
                                Image(systemName: "play.circle.fill")
                                .resizable()
                                .frame(width: 30.0, height: 30.0, alignment:
                                    .bottom)
                                    .foregroundColor(Color.blue)
                                    Spacer()
                            }
                            Spacer()
                        })
                    }
                        
                        
                        
                        Image("icon_token_sm")
                        .resizable()
                        .frame(width: 15.0, height: 15.0)
                        
                        Text("\(Int(coins)) jetons gratuits")
                            .font(.caption)
                            .foregroundColor(Color.white)
                    }
                    .padding()
                }
                Spacer()
            }
            .alert(isPresented: $alertCart) {
                Alert(title: Text("Vérifiez votre panier"))
            }
        }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
        
//        ShopView(GameManager.instance.currentUser.coins)
    }
}
