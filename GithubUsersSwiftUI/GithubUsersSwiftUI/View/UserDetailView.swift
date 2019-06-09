//
//  UserDetailView.swift
//  GithubUsersSwiftUI
//
//  Created by Ben Kray on 6/8/19.
//  Copyright © 2019 Ben Kray. All rights reserved.
//

import SwiftUI

struct UserDetailView : View {

    @ObjectBinding var userViewModel: GithubUserViewModel
    private let imageStore = UserImageStore()

    var body: some View {
        ZStack(alignment: .top) {
            UserImageView(user: userViewModel.user, imageStore: imageStore)
                .aspectRatio(contentMode: .fill)
                .frame(height: 100.0)
                .offset(x: 0.0, y: -50.0)
                .foregroundColor(.green)
                .blur(radius: 4.0, opaque: true)
            VStack(alignment: .center) {
                UserImageView(user: userViewModel.user, imageStore: imageStore)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 2.0)
                    .cornerRadius(50.0)
                    .frame(width: 100.0, height: 100.0)
                HStack {
                    VStack(alignment: .leading) {
                        Text(userViewModel.githubUserDetail?.name ?? "--")
                            .font(.largeTitle)
                            .bold()
                        Text(userViewModel.user.login)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(userViewModel.githubUserDetail?.bio ?? "")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.vertical, 5.0)
                    }
                    Spacer()
                }.padding(.vertical, 10.0)
            }
                .padding(.all, 40.0)
                .offset(x: 0.0, y: 100.0)
                .background(RoundedRectangle(cornerRadius: 4.0)
                    .frame(width: UIScreen.main.bounds.width - 40.0)
                    .foregroundColor(.white)
                    .offset(x: 0.0, y: 100.0)
                    .shadow(radius: 2.0))
            Spacer()
        }

    }
}

#if DEBUG
struct UserDetailView_Previews : PreviewProvider {
    static var previews: some View {
        let user = GithubUser(login: "nebyark", id: 1, nodeID: "", avatarURL: "", gravatarID: "", url: "", htmlURL: "someurl", followersURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", receivedEventsURL: "", type: "", score: 12.0)
        return UserDetailView(userViewModel: GithubUserViewModel(user: user))
    }
}
#endif
