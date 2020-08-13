//
//  Profile.swift
//  App_cinema
//
//  Created by Henry Franceschi on 05/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

//struct UserFriendView: View {
//    var user: ProfilePreview
//
//    var body: some View {
//        VStack {
//            Image(user.profileImage, scale: 1.0, label: Text("\("Profile picture of " + user.nickName)"))
//            Text(user.nickName)
//        }
//    }
//}

struct ProfileView: View {
    
    @ObservedObject var profileVM: ProfileViewModel
    
    // Progression
    var percentage: Int = 75
    
    // Style, get from player preferences if there is time
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(Color.darkBlueEnd, Color.darkBlueStart)
                .edgesIgnoringSafeArea(.all)
            
            
            // THE PROFILE
            VStack(alignment: .center, spacing: 20) {
                // Image must be in centre so that the progress bar can be aligned properly
                ZStack {
                    
                    // Shadow blended with background
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.offWhite1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -10, y: -10)
                        .blendMode(.overlay)
                    // The card
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.offWhite1.opacity(0.95))
                    
                    VStack {
                        // Main user image
                        Image(profileVM.user.profileImage, scale: 1, label: Text("\("Profile picture of " + profileVM.user.nickName)"))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -10, y: -10)
                        
                        // NICKNAME LABEL
                        VStack {
                            VStack {
                                HStack(alignment: .center, spacing: 5) {
                                    Text(profileVM.user.nickName)
                                        .fontWeight(.bold)
                                        .font(.headline).lineLimit(1)
                                    
                                    StatusIndicator(isOnline: profileVM.user.isOnline ?? false)
                                }
                                Text("#\(profileVM.user.id)")
                                    .font(Font.system(size: 10))
                                    .foregroundColor(Color.gray)
                            }
                            .padding(5)
                            .frame(maxWidth: 125)
                            .background(ForegroundCard())
                            
                        }
                    }
                }
                .padding(.top, 85)
                .frame(width: UIScreen.main.bounds.size.width - 20, height: 300)
                
                // USER STATISTICS SECTION
                if profileVM.user.statistics != nil {
                    VStack(alignment: .leading, spacing: 10.0) {
                        
                        // The section label
                        HStack {
                            // If the current user is not the owner of the profile
                            if GameManager.instance.currentUser.id != profileVM.user.id {
                                Text("Statistiques de \(profileVM.user.nickName):")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                Spacer()
                            } else {
                                Text("Vos statistiques:")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                        }
                        .padding(15)
                        .frame(width: UIScreen.main.bounds.width - 20, height: 20)
                        
                        HStack(alignment: .firstTextBaseline, spacing: 10) {
                            //                            Image(systemName: "h.circle.fill")
                            Text("Heures jouées:")
                                .font(.subheadline)
                            Text(String(format: "%.1f", profileVM.user.statistics!.hoursPlayed))
                                .font(.subheadline)
                        }
                        .padding(.horizontal, 15)
                        HStack(alignment: .firstTextBaseline, spacing: 10) {
                            //                            Image(systemName: "j.circle.fill")
                            Text("Jetons gagnés:")
                                .font(.subheadline)
                            Text(String(profileVM.user.statistics!.coins))
                                .font(.subheadline)
                        }
                        .padding(.horizontal, 15)
                    }
                        // Width must be fixed, but height will change depending on the contents
                        .frame(width: UIScreen.main.bounds.width - 20)
                        .padding(.vertical)
                        .background(BackgroundCard())
                }
                // END OF USER STATISTICS SECTION
                
                // USER ACHIEVEMENTS SECTION
                if profileVM.user.statistics != nil {
                    VStack(alignment: .center, spacing: 10.0) {
                        
                        // The section label
                        HStack {
                            // If the current user is not the owner of the profile
                            if GameManager.instance.currentUser.id != profileVM.user.id {
                                Text("Récompenses de \(profileVM.user.nickName):")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                Spacer()
                            } else {
                                Text("Vos récompenses:")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                        }
                        .padding(15)
                        .frame(width: UIScreen.main.bounds.width - 20, height: 20)
                        
                        HStack(alignment: .firstTextBaseline, spacing: 10) {
                            // Achievements
                            ZStack {
                                Image(systemName: "hexagon.fill")
                                    .foregroundColor(.orange)
                                    .font(Font.system(size: 40))
                                Image(systemName: "10.circle.fill")
                                    .foregroundColor(.red)
                                .font(Font.system(size: 25))
                            }
                            .frame(width: 50, height: 50)
                            .background(ForegroundCardColored(color: Color.red.opacity(0.8)))
                            
                            ZStack {
                                Image(systemName: "hexagon.fill")
                                    .foregroundColor(.green)
                                    .font(Font.system(size: 40))
                                Image(systemName: "flame.fill")
                                    .foregroundColor(Color.purple.opacity(0.8))
                                .font(Font.system(size: 25))
                            }
                            .frame(width: 50, height: 50)
                            .background(ForegroundCardColored(color: Color.purple.opacity(0.8)))
                            
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(Color.pink)
                                    .font(Font.system(size: 40))
                                Image(systemName: "bolt.fill")
                                    .foregroundColor(Color.yellow.opacity(0.8))
                                    .font(Font.system(size: 25))
                            }
                            .frame(width: 50, height: 50)
                            .background(ForegroundCardColored(color: Color.blue.opacity(0.8)))
                            
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(Color.green)
                                    .font(Font.system(size: 40))
                                Image(systemName: "clock.fill")
                                    .foregroundColor(Color.black.opacity(0.8))
                                    .font(Font.system(size: 25))
                            }
                            .frame(width: 50, height: 50)
                            .background(ForegroundCardColored(color: Color.black.opacity(0.8)))
                            
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(Color.yellow)
                                    .font(Font.system(size: 40))
                                Image(systemName: "lightbulb.fill")
                                    .foregroundColor(Color.white.opacity(0.7))
                                    .font(Font.system(size: 25))
                            }
                            .frame(width: 50, height: 50)
                            .background(ForegroundCardColored(color: Color.orange.opacity(0.8)))
                            
                            // Empty only here
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(Color.yellow)
                                    .font(Font.system(size: 40))
                            }
                            .frame(width: 50, height: 50)
                            .background(ForegroundCardColored(color: Color.orange.opacity(0.8)))
                            .opacity(0.0)
                        }
                        .padding(.horizontal, 15)
                    }
                        // Width must be fixed, but height will change depending on the contents
                        .frame(width: UIScreen.main.bounds.width - 20)
                        .padding(.vertical)
                        .background(BackgroundCard())
                }
                // END OF USER ACHIEVEMENTS SECTION
                
                // FRIENDS SECTION
                if profileVM.userHasPermission {
                    VStack(alignment: .center) {
                        
                        // The section label
                        HStack(alignment: .firstTextBaseline) {
                            // If the current user is not the owner of the profile
                            if GameManager.instance.currentUser.id != profileVM.user.id {
                                Text("Les amis de \(profileVM.user.nickName):")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            } else {
                                Text("Vos amis:")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                            
                            Spacer()
                            StatusIndicator(isOnline: profileVM.numFriendsOnline > 0)
                            Text("\(profileVM.numFriendsOnline) Online")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Button(action: {
                                self.profileVM.isShowingAllFriends = true
                            }) {
                                Image(systemName: "ellipsis.circle.fill")
                                    .foregroundColor(Color.gray)
                            }
                            Button(action: {
                                self.profileVM.isShowingSearch = true
                            }) {
                                Image(systemName: "magnifyingglass.circle.fill")
                                    .foregroundColor(Color.gray)
                            }
                        }
                        .padding(15)
                        .frame(width: UIScreen.main.bounds.width - 20, height: 20)
                        
                        // The list of friends itself
                        HStack(alignment: .center, spacing: 10) {
                            if profileVM.friends.count != 0 {
                                ForEach(0..<4, id: \.self) { index in
                                    NavigationLink(destination: ProfileView(profileVM: ProfileViewModel(userID: self.profileVM.friends[index].id))) {
                                        UserProfilePreview(user: self.profileVM.friends[index])
                                            .foregroundColor(.black)
                                            .padding(.horizontal, -2.5)
                                        // So the card overlaps is slightly pushed over the edge of the card
//                                            .offset(x: 0, y: 25)
//                                            .padding(.top, -15)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical)
                    .background(BackgroundCard())
                }
                else {
                    VStack {
                        Text("You do not have permission to view this profile.")
                    }
                }
                // END OF FRIEND SECTION
                
                
                Spacer()
                
            }
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: $profileVM.isShowingAllFriends) {
                FriendSheet(friendList: self.profileVM.friends)
            }
            .sheet(isPresented: $profileVM.isShowingSearch) {
                SearchView()
            }
        }
        .onAppear {
            self.profileVM.loadUsersFriends()
        }
        
    }
    
}

// OTHER STUFF
struct FriendSheet: View {
    var friendList: [ProfilePreview]
    var body: some View {
        VStack {
            Text("Friends")
                .padding()
                .font(.title)
            ScrollView{
                ForEach(friendList) { friend in
                    UserProfilePreviewLarge(user: friend)
                }.padding()
            }
        }
    }
}

struct StatusIndicator: View {
    var isOnline: Bool
    
    var body: some View {
        Circle()
            .fill(isOnline ? LinearGradient.profileOnlineIndicatorGradient : LinearGradient.profileOfflineIndicatorGradient)
            .frame(width: 10, height: 10)
            .shadow(color: isOnline ? Color.green.opacity(0.7) : Color.black.opacity(0.2), radius: 2, x: 1.5, y: 1.5)
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profileVM: ProfileViewModel(userID: GameManager.instance.currentUser.id))
    }
}

struct ForegroundCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.offWhite1)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -10, y: -10)
        }
    }
}

struct ForegroundCardColored: View {
    var color: Color
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -10, y: -10)
        }
    }
}

struct BackgroundCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.offWhite1)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -10, y: -10)
                .blendMode(.overlay)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.offWhite1)
        }
    }
}
