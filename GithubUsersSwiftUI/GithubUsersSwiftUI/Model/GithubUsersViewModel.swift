//
//  GithubUsersViewModel.swift
//  GithubUsersSwiftUI
//
//  Created by Ben Kray on 6/7/19.
//  Copyright © 2019 Ben Kray. All rights reserved.
//

import Combine
import SwiftUI

class GithubUsersViewModel: BindableObject {

    var didChange = PassthroughSubject<Void, Never>()
    let queryText = PassthroughSubject<String, Error>()

    var text: String = "" {
        didSet {
            query()
        }
    }
    var users: [GithubUser] = [] {
        didSet {
            DispatchQueue.main.async {
                self.didChange.send(())
            }
        }
    }

    init() {
        let _ = queryText
            // see 51241500 https://developer.apple.com/documentation/xcode_release_notes/xcode_11_beta_release_notes/
//             .debounce(for: 1.0, scheduler: RunLoop.main)
//            .removeDuplicates()
            .filter { !$0.isEmpty }
            .compactMap { GithubUsersSearchAPI.users(query: $0).url }
            .flatMap { url -> AnyPublisher<(Data, URLResponse), Error> in
                return URLSession.shared.data(with: URLRequest(url: url))
            }
            .map { $0.0 }
            .decode(type: GithubUsers.self, decoder: JSONDecoder())
            .sink { self.users = $0.items }
    }

    func query() {
        if text.isEmpty {
            users = []
        }

        queryText.send(text)
    }

}

