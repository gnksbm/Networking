//
//  HTTPProvider.swift
//  Networking
//
//  Created by gnksbm on 6/28/25.
//

import Foundation

public protocol HTTPProvider {
    func request<R: HTTPRequest>(_ request: R) async throws -> HTTPResponse
}

extension URLSession: HTTPProvider {
    public func request<R: HTTPRequest>(_ request: R) async throws -> HTTPResponse {
        let urlRequest = try request.urlRequest
        let (data, response) = try await data(for: urlRequest)
        guard let httpURLResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        return HTTPResponse(data: data, httpURLResponse: httpURLResponse)
    }
}
