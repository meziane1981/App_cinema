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
    @Published var user: Profile
    @Published var friends: [ProfilePreview]
    @Published var numFriendsOnline: Int
    
    @Published var userHasPermission: Bool = false
    @Published var isShowingAllFriends: Bool = false
    @Published var isShowingSearch: Bool = false
    
    init(userID: Int) {
        // For permissions we need the current user
        let currentUser = GameManager.instance.currentUser
        
        os_log("Creating profile of user(%i)", log: .default, type: .info, userID)
        
        // Making this explicit now as there were problems earlier when it was just the GameManager in charge of this
        let permissions = currentUser.friends.contains(userID) || currentUser.id == userID
        if permissions == false {
            os_log("The current user %i does not have permission to view ths profile of user(%i)", log: .default, type: .info, GameManager.instance.currentUser.id, userID)
        }

        
        // Try to get userData
        if let userData = GameManager.instance.requestUserDetails(userID) {
            os_log("Getting full data of user(%i)", log: .default, type: .info, userID)
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
                os_log("Something went wrong when trying to retrieve the data for for user(%i)", log: .default, type: .info, userID)
                self.user = Profile.placeholderProfile
            }
        }
        
        self.friends = []
        self.numFriendsOnline = 0
        self.userHasPermission = permissions
    }
    
    func loadUsersFriends() {
        // If we have already loaded the questions do nothing
        if user.friends?.count == friends.count {
            return
        }
        
        if user.friends != nil {
            
            var loadedFriends: [ProfilePreview] = []
            
            for (index, value) in user.friends!.enumerated() {
                
                loadedFriends.append(ProfilePreview(basicUserData: GameManager.instance.requestUserBasicInfo(value)!))
                os_log("Loading basic data of user(%i) friend of user(%i)", log: .default, type: .info, loadedFriends[index].id, user.id)
                
                // If we don't know whether a user is online or not because we lack the permissions then default to false
                if loadedFriends[index].isOnline ?? false {
                    // If they are online we add one to the online friends count
                    numFriendsOnline += 1
                }
                // Make sure that the friends that are online are first in the list
                // Sort here by whether they are online or not and then alphabetically
                
            }
            // When we are done assign it to friends
            self.friends = loadedFriends
        }
    }
}
