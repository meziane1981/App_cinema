//
//  Search.swift
//  App_cinema
//
//  Created by Henry Franceschi on 05/08/2020.
//  Copyright © 2020 Groupe Cinéma. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State var users: [BasicUserData] = []
    @State var searchStr: String = ""

    var body: some View {

        VStack(alignment: .leading, spacing: 5) {

            HStack {
                TextField("search for user", text: $searchStr)

                Button(action: {
                    self.users = GameManager.instance.findUsersByNickName(self.searchStr)
//                    self.users = GameManager.instance.findUsers(self.searchStr, \.nickName)
                }) {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(Font.system(size: 30))
                }
            }.padding(20)
                List {
                    ForEach(users) { user in
                        NavigationLink(destination: ProfileView(profileVM: ProfileViewModel(userID: user.id))) {
                            UserProfilePreviewLarge(user: ProfilePreview(basicUserData: user))
                        }
                    }
                }
            Spacer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
