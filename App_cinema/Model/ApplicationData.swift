//
//  UserData.swift
//  App_cinema
//
//  Created by Henry Franceschi on 04/08/2020.
//  Copyright © 2020 William Paparone. All rights reserved.
//

import SwiftUI

struct UserData: Decodable {
    var id: Int
    var username: String
    var firstName: String
    var lastName: String
    var image: String
}
