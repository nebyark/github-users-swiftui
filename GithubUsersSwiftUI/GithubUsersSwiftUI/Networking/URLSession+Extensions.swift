//
//  GithubUsersSearchAPI.swift
//  GithubUsersSwiftUI
//
//  Created by Ben Kray on 6/7/19.
//  Copyright © 2019 Ben Kray. All rights reserved.
//

import Foundation
import Combine

extension URLSession {

    func data(with request: URLRequest) -> AnyPublisher<(Data, URLResponse), Error> {
        return AnyPublisher<(Data, URLResponse), Error> { subscriber in
            let task = self.dataTask(with: request) { data, response, error in
                if let data = data, let response = response {
                    _ = subscriber.receive((data, response))
                    subscriber.receive(completion: .finished)
                } else if let error = error {
                    subscriber.receive(completion: .failure(error))
                }
            }
            task.resume()
        }
    }

}
