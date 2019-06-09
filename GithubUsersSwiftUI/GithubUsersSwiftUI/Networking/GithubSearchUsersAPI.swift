//
//  GithubSearchUsersAPI.swift
//  GithubUsersSwiftUI
//
//  Created by Ben Kray on 6/7/19.
//  Copyright © 2019 Ben Kray. All rights reserved.
//

import Combine
import SwiftUI

enum GithubUsersSearchAPI {

    case users(query: String)
    case user(username: String)

    var url: URL {
        switch self {
        case .users(let query):
            return URL(string: "https://api.github.com/search/users?q=\(query)")!
        case .user(let username):
            return URL(string: "https://api.github.com/users/\(username)")!
        }
    }

    static func fetchImage(at url: URL, completion: @escaping (Image?, Error?) -> Void) {
        if let image = ImageCache.shared.image(for: url) {
            completion(image, nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                let result = Image(uiImage: image)
                ImageCache.shared.store(image: result, url: url)
                completion(result, error)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }

    static func fetchUser(username: String, completion: @escaping (GithubUserDetail?) -> Void) {
        let url = GithubUsersSearchAPI.user(username: username).url
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, let jsonString = String(data: data, encoding: .utf8) else {
                return
            }
            // -_-
            let sanitized = jsonString.replacingOccurrences(of: "null,", with: "\"\",")
            let sanitizedData = sanitized.data(using: .utf8)
            do {
                let user = try  JSONDecoder().decode(GithubUserDetail.self, from: sanitizedData!)
                completion(user)
            } catch { }
        }
        task.resume()
    }

}

extension JSONDecoder: TopLevelDecoder { }
