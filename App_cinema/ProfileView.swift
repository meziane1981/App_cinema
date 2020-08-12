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
                            .background(ForegroundCard())
                            
                        }
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 20, height: 300)
                    .background(BackgroundCard())
                
                
                
                // USER STATISTICS SECTION
                if profileVM.user.statistics != nil {
                    VStack(alignment: .center, spacing: 10.0) {
                        
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
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 20, height: 20)
                        
                        Text("\("Heures jouées: " + String(format: "%.1f", profileVM.user.statistics!.hoursPlayed))")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        HStack(alignment: .center, spacing: 10.0) {
                            Text("Jetons: \(profileVM.user.statistics!.coins)")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Image("token")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .shadow(radius: 10)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 20)
                    .padding(.vertical)
                    .background(BackgroundCard())
                }
                // END OF USER STATISTICS SECTION
                
                // FRIENDS SECTION
                if profileVM.userHasPermission {
                    VStack(alignment: .center) {
                        
                        // The section label
                        HStack {
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
                        }
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 20, height: 20)
                        
                        // The list of friends itself
                        HStack(alignment: .center, spacing: 10) {
                            if profileVM.friends.count != 0 {
                                ForEach(0..<4, id: \.self) { index in
                                    NavigationLink(destination: ProfileView(profileVM: ProfileViewModel(userID: self.profileVM.friends[index].id))) {
                                        UserProfilePreview(user: self.profileVM.friends[index])
                                            .foregroundColor(.black)
                                            .padding(.horizontal, -2.5)
                                            .offset(x: 0, y: 25)
                                            .padding(.top, -15)
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
            .sheet(isPresented: $profileVM.isShowingAllFriends) {
                FriendSheet(friendList: self.profileVM.friends)
            }
        }
        .edgesIgnoringSafeArea(.all)
        
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
