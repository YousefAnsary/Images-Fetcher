//
//  FailedRequest.swift
//  images-fetcher
//
//  Created by Youssef on 07/04/2023.
//

struct FailedRequest: Error {

    private let statusCode: Int

    init(statusCode: Int) {
        self.statusCode = statusCode
    }
}
