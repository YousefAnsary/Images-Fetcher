//
//  APIClientImpl.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

import Foundation

class APIClientImpl: APIClient {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func get<T: Decodable>(url: String) async throws -> T {
        guard let url = URL(string: url) else { throw InvalidURL() }
        let res = try await self.session.data(from: url)
        let statusCode = (res.1 as? HTTPURLResponse)?.statusCode ?? 404
        guard (200...299).contains(statusCode) else {
            throw FailedRequest(statusCode: statusCode)
        }
        return try JSONDecoder().decode(T.self, from: res.0)
    }
}
