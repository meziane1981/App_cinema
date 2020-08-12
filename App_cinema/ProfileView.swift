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
            
            Color.blue
                .opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            // THE PROFILE
            VStack(alignment: .center, spacing: 75) {
                    // Image must be in centre so that the progress bar can be aligned properly
                    VStack {
                        Image(profileVM.user.profileImage, scale: 1, label: Text("\("Profile picture of " + profileVM.user.nickName)"))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                        
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
                            .frame(maxWidth: 150)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.offWhite1))
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                        }
                    }
                .frame(width: UIScreen.main.bounds.size.width, height: 300)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                    .fill(Color.offWhite1.opacity(0.95))
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -10, y: -10))
                .edgesIgnoringSafeArea(.top)
                
                // USER STATISTICS SECTION
                if profileVM.user.statistics != nil {
                    VStack {
                        Text("\("Hours Played: " + String(format: "%.0f", profileVM.user.statistics!.hoursPlayed))")
                            .font(.headline)
                        HStack {
                            Text("Coins: \(profileVM.user.statistics!.coins)")
                                .font(.headline)
                            Image("icon_token_wh")
                            .resizable()
                            .frame(width: 20, height: 20)
                        }
                    }
                .padding()
                    .background(CardShadowedBlended())
                }
                // END OF USER STATISTICS SECTION
                
                // FRIENDS SECTION
                if profileVM.userHasPermission {
                    VStack(alignment: .center) {
                        
                        // The section label
                        HStack {
                            // If the current user is not the owner of the profile
                            if GameManager.instance.currentUser.id != profileVM.user.id {
                                Text("\(profileVM.user.nickName + String(profileVM.user.nickName[profileVM.user.nickName.index(before: profileVM.user.nickName.endIndex)] != "s" ? "'s" : "'")) friends:")
                                    .font(.subheadline)
                            } else {
                                Text("Your friends:")
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
                        }
                        .padding()
                        .frame(height: 20)
                        
                        // The list of friends itself
                        HStack(alignment: .center, spacing: 10) {
                            if profileVM.friends.count != 0 {
                                ForEach(0..<4, id: \.self) { index in
                                    NavigationLink(destination: ProfileView(profileVM: ProfileViewModel(userID: self.profileVM.friends[index].id))) {
                                        UserProfilePreview(user: self.profileVM.friends[index])
                                            .offset(x: 0, y: 20)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical)
                    .background(CardShadowedBlended())
                }
                else {
                    VStack {
                        Text("You do not have permission to view this profile.")
                    }
                }
                // END OF FRIEND SECTION
                
                Spacer()
                
            }
        }
        .sheet(isPresented: $profileVM.isShowingAllFriends) {
            FriendSheet(friendList: self.profileVM.friends)
        }
        
    }
}

// OTHER STUFF

struct FriendSheet: View {
    var friendList: [ProfilePreview]
    var body: some View {
        List {
            ForEach(friendList) { friend in
                UserProfilePreview(user: friend)
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

struct CardShadowed: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.offWhite2)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
        }
    }
}

// Will become the same color as the background
struct CardShadowedOverlayed: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.offWhite1)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                .blendMode(.overlay)
        }
    }
}

struct CardShadowedBlended: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.profileBackgroundColor)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                .blendMode(.overlay)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.offWhite1)
        }
    }
}
