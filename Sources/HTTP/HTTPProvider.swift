//
//  HTTPProvider.swift
//  Networking
//
//  Created by gnksbm on 6/28/25.
//

import Foundation

public protocol HTTPProvider {
    var eventMonitor: EventMonitor? { get }
    
    func request<R: HTTPRequest>(_ request: R) async throws -> HTTPResponse
}

extension URLSession: HTTPProvider {
    public var eventMonitor: EventMonitor? { nil }
    
    public func request<R: HTTPRequest>(_ request: R) async throws -> HTTPResponse {
        eventMonitor?.didRequest(request)
        do {
            let urlRequest = try request.urlRequest
            let (data, response) = try await data(for: urlRequest)
            guard let httpURLResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            let httpResponse = HTTPResponse(data: data, httpURLResponse: httpURLResponse)
            eventMonitor?.didRecieve(request, httpURLResponse: httpResponse)
            return httpResponse
        } catch {
            eventMonitor?.didError(request, error: error)
            throw error
        }
    }
}
