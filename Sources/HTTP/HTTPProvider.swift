//
//  HTTPProvider.swift
//  Networking
//
//  Created by gnksbm on 6/28/25.
//

import Foundation

public protocol HTTPProvider {
    var eventMonitor: HTTPEventMonitor? { get }
    
    func request<R: HTTPRequest>(_ request: R) async throws -> HTTPResponse
}

public extension HTTPProvider {
    var eventMonitor: HTTPEventMonitor? { HTTPLogger() }
}

extension URLSession: HTTPProvider {
    public func request<R: HTTPRequest>(_ request: R) async throws -> HTTPResponse {
        if request.isMonitoringEnabled {
            eventMonitor?.didRequest(request)
        }
        do {
            let urlRequest = try request.urlRequest
            let (data, response) = try await data(for: urlRequest)
            guard let httpURLResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            let httpResponse = HTTPResponse(data: data, httpURLResponse: httpURLResponse)
            if request.isMonitoringEnabled {
                eventMonitor?.didRecieve(request, httpURLResponse: httpResponse)
            }
            return httpResponse
        } catch {
            if request.isMonitoringEnabled {
                eventMonitor?.didError(request, error: error)
            }
            throw error
        }
    }
}
