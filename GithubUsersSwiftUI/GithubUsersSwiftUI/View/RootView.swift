//
//  RootView.swift
//  GithubUsersSwiftUI
//
//  Created by Ben Kray on 6/7/19.
//  Copyright © 2019 Ben Kray. All rights reserved.
//

import SwiftUI

struct RootView: View {

    @EnvironmentObject var viewModel: GithubUsersViewModel

    var body: some View {
        NavigationView {
            VStack {
                TextField($viewModel.text,
                          placeholder: Text("Search users...").font(.system(size: 20.0)),
                          onCommit: { self.viewModel.query() })
                    .textContentType(.username)
                    .padding(.horizontal, 20.0)
                    .frame(height: 40.0)
                Divider()
            }
            UsersListView(viewModel: viewModel)
                .navigationBarTitle(Text("Users"))
        }
    }

}

#if DEBUG
struct RootView_Previews : PreviewProvider {
    static var previews: some View {
        let viewModel = GithubUsersViewModel()
        let user = GithubUser(login: "nebyark", id: 1, nodeID: "", avatarURL: "", gravatarID: "", url: "", htmlURL: "someurl", followersURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", receivedEventsURL: "", type: "", score: 12.0)
        viewModel.users = [user]
        return RootView().environmentObject(viewModel)
    }
}
#endif
