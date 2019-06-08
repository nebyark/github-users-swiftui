//
//  UsersListView.swift
//  GithubUsersSwiftUI
//
//  Created by Ben Kray on 6/7/19.
//  Copyright © 2019 Ben Kray. All rights reserved.
//

import SwiftUI

struct UsersListView : View {

    @ObjectBinding var viewModel: GithubUsersViewModel

    var body: some View {
        Section(footer: EmptyView()) {
            List {
                ForEach(self.viewModel.users) { user in
                    UserRow(user: user)
                }
            }
        }
    }

}

#if DEBUG
struct UsersListView_Previews : PreviewProvider {
    static var previews: some View {
        let viewModel = GithubUsersViewModel()
        return UsersListView(viewModel: viewModel)
    }
}
#endif
