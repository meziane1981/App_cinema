//
//  ProfileViewModel.swift
//  App_cinema
//
//  Created by Henry Franceschi on 10/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import Foundation
import SwiftUI
import os.log

final class ProfileViewModel: ObservableObject {
    // The user that the profile belongs to
    var user: Profile
    var friends: [ProfilePreview]
    var numFriendsOnline: Int
    
    // State changing stuff
    @Published var userHasPermission: Bool
    @Published var isShowingAllFriends: Bool = false
    
    init(userID: Int) {
        // For permissions we need the current user 
        let currentUser = GameManager.instance.currentUser
        
        os_log("Creating profile for user(%i)", log: .default, type: .info, userID)
        
        // Making this explicit now as there were problems earlier when it was just the GameManager in charge of this
        userHasPermission = currentUser.friends.contains(userID) || currentUser.id == userID
        os_log("The current user %i does not have permission to view ths profile of user(%i)", log: .default, type: .info, GameManager.instance.currentUser.id, userID)
        
        // Try to get userData
        if let userData = GameManager.instance.requestUserDetails(userID) {
            os_log("Getting full data for user(%i)", log: .default, type: .info, userID)
            self.user = Profile(userData: userData)
        }
        else {
            // If we are not friends with them, we get basic data
            os_log("The current user is not friends with user(%i)", log: .default, type: .info, userID)
            if let basicUserData = GameManager.instance.requestUserBasicInfo(userID) {
                // Create profile from basic data
                os_log("Getting basic data for user(%i)", log: .default, type: .info, userID)
                self.user = Profile(basicUserData: basicUserData)
            } else {
                // Use placeholder
                os_log("Something went wrong when trying to retrieve the data for for user %i", log: .default, type: .info, userID)
                self.user = Profile.placeholderProfile
            }
        }
        
        self.friends = []
        self.numFriendsOnline = 0
        
        if user.friends != nil {
            for friendID in user.friends! {
                let friend = ProfilePreview(basicUserData: GameManager.instance.requestUserBasicInfo(friendID)!)
                os_log("Loading data of user(%i) friend of user(%i)", log: .default, type: .info,friend.id, userID)
                self.friends.append(friend)
                
                if friend.isOnline ?? false {
                    numFriendsOnline += 1
                }
                // Make sure that the friends that are onlie are first in the list
            }
        }
    }
}
