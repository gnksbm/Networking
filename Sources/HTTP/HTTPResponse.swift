//
//  HTTPResponse.swift
//  Networking
//
//  Created by gnksbm on 6/28/25.
//

import Foundation

public struct HTTPResponse {
    public let data: Data
    public let httpURLResponse: HTTPURLResponse
}

public extension HTTPResponse {
    @discardableResult
    func validateSuccessStatusCode() throws -> Self {
        guard (200..<300).contains(httpURLResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return self
    }
}
