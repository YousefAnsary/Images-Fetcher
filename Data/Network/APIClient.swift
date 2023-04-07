//
//  APIClient.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

import Foundation

protocol APIClient {
    func get<T: Decodable>(url: String) async throws -> T
}
