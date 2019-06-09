//
//  GithubUsers.swift
//  GithubUsersSwiftUI
//
//  Created by Ben Kray on 6/7/19.
//  Copyright © 2019 Ben Kray. All rights reserved.
//

import SwiftUI

struct GithubUsers: Codable {

    let totalCount: Int
    let incompleteResults: Bool
    let items: [GithubUser]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }

}

struct GithubUser: Codable, Identifiable {

    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, htmlURL, followersURL, subscriptionsURL: String
    let organizationsURL, reposURL, receivedEventsURL: String
    let type: String
    let score: Double

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case receivedEventsURL = "received_events_url"
        case type, score
    }

}

struct GithubUserDetail: Codable, Identifiable {

    let login: String
    let id: Int
    let avatarURL: String
    let type: String
    let name: String?
    let company: String?
    let location: String?
    let bio: String?
    let publicRepos, publicGists, followers, following: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case type
        case name, company, location, bio
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
