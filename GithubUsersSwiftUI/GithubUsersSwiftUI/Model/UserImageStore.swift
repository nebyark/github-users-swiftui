//
//  UserImageStore.swift
//  GithubUsersSwiftUI
//
//  Created by Ben Kray on 6/8/19.
//  Copyright © 2019 Ben Kray. All rights reserved.
//

import SwiftUI
import Combine

class UserImageStore: BindableObject {

    var didChange = PassthroughSubject<Void, Never>()
    var image: Image? {
        didSet {
            DispatchQueue.main.async {
                self.didChange.send(())
            }
        }
    }

    func load(image url: String) -> Self {
        if image == nil {
            GithubUsersSearchAPI.fetchImage(at: URL(string: url)!) { image in
                self.image = image
            }
        }

        return self
    }

}

class ImageCache {

    static let shared = ImageCache()
    private var cache = [String: Image]()

    private init() { }
    
    func image(for url: URL) -> Image? {
        cache[url.absoluteString]
    }

    func store(image: Image, url: URL) {
        cache[url.absoluteString] = image
    }

}
