//
//  UserRow.swift
//  GithubUsersSwiftUI
//
//  Created by Ben Kray on 6/7/19.
//  Copyright © 2019 Ben Kray. All rights reserved.
//

import SwiftUI

struct RatingView: View {

    let score: Double
    var color: Color {
        switch score {
        case 0.0...30.0:
            return .red
        case 30.0...50.0:
            return .yellow
        default:
            return .green
        }
    }

    var body: some View {
        Text("\(Int(score))")
            .font(.footnote)
            .bold()
            .color(.white)
            .padding(.vertical, 4.0)
            .frame(width: 40.0)
            .background(RoundedRectangle(cornerRadius: 4.0).foregroundColor(color))
    }

}

struct UserRow : View {

    let user: User
    let imageStore = UserImageStore()

    var body: some View {
        HStack(alignment: .center, spacing: 12.0) {
            UserImageView(user: user, imageStore: imageStore)
            VStack(alignment: .leading) {
                Text(user.login)
                    .font(.headline)
                Text(user.htmlURL)
                    .font(.footnote)
                    .color(.secondary)
            }
            Spacer()
            Image(systemName: user.type == "User" ? "person" : "person.and.person")
            RatingView(score: user.score)
        }.frame(height: 40.0)
    }

}

#if DEBUG
struct UserRow_Previews : PreviewProvider {
    static var previews: some View {
        let user = User(login: "nebyark", id: 1, nodeID: "", avatarURL: "", gravatarID: "", url: "", htmlURL: "https://someurl.com", followersURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", receivedEventsURL: "", type: "", score: 12.0)
        return UserRow(user: user)
            .frame(height: 80.0)
    }
}
#endif
