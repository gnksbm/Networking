//
//  HTTPRequest.swift
//  Networking
//
//  Created by gnksbm on 6/28/25.
//

import Foundation

public protocol HTTPRequest {
    var method: HTTPMethod { get }
    var scheme: HTTPScheme { get }
    var baseURL: String { get }
    var port: Int? { get }
    var path: String { get }
    var queries: [String: String] { get }
    var headers: [String: String] { get }
    var body: Data? { get }
}

public extension HTTPRequest {
    var port: Int? { nil }
    var queries: [String: String] { [:] }
    var headers: [String: String] { [:] }
    var body: Data? { nil }
}

extension HTTPRequest {
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme.string
        urlComponents.host = baseURL
        urlComponents.port = port
        urlComponents.path = path
        if !queries.isEmpty {
            urlComponents.queryItems = queries.map {
                .init(name: $0.key, value: $0.value)
            }
        }
        return urlComponents
    }
    
    var url: URL {
        get throws {
            guard let url = urlComponents.url else { throw URLError(.badURL) }
            return url
        }
    }
    
    var urlRequest: URLRequest {
        get throws {
            let url = try url
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.string
            urlRequest.allHTTPHeaderFields = headers
            urlRequest.httpBody = body
            return urlRequest
        }
    }
}
