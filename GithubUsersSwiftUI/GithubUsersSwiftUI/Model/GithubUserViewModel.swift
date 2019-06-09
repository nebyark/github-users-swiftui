//
//  GithubUserViewModel.swift
//  GithubUsersSwiftUI
//
//  Created by Ben Kray on 6/8/19.
//  Copyright © 2019 Ben Kray. All rights reserved.
//

import Combine
import SwiftUI

class GithubUserViewModel: BindableObject {

    var didChange = PassthroughSubject<Void, Never>()
    let user: GithubUser
    private(set) var githubUserDetail: GithubUserDetail? {
        didSet {
            DispatchQueue.main.async {
                self.didChange.send(())
            }
        }
    }

    init(user: GithubUser) {
        self.user = user
        GithubUsersSearchAPI.fetchUser(username: user.login) { userDetail in
            if let userDetail = userDetail {
                self.githubUserDetail = userDetail
            }
        }
    }
}
