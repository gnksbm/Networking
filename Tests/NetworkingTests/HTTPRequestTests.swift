//
//  HTTPRequestTests.swift
//  Networking
//
//  Created by gnksbm on 6/28/25.
//

import Foundation
import Testing
@testable import Networking

struct DummyRequest: HTTPRequest {
    var scheme: HTTPScheme { .https }
    var baseURL: String { "example.com" }
    var path: String { "/path" }
    var method: HTTPMethod { .post }
    var headers: [String: String] { ["Content-Type": "application/json"] }
    var body: Data? { "body".data(using: .utf8) }
}

struct BadRequest: HTTPRequest {
    var scheme: HTTPScheme { .other("ftp") }
    var baseURL: String { "bad host" }
    var path: String { "/bad path" }
    var method: HTTPMethod { .get }
}

@Test func testURLComponents() async throws {
    let req = DummyRequest()
    let components = req.urlComponents
    #expect(components.scheme == "https")
    #expect(components.host == "example.com")
    #expect(components.path == "/path")
}

@Test func testURL() async throws {
    let req = DummyRequest()
    let url = try req.url
    #expect(url.scheme == "https")
    #expect(url.host == "example.com")
    #expect(url.path == "/path")
}

@Test func testURLThrowsBadURL() async throws {
    #expect(throws: URLError(.badURL)) {
        try BadRequest().url
    }
}

@Test func testURLRequest() async throws {
    let req = DummyRequest()
    let urlRequest = try req.urlRequest
    #expect(urlRequest.httpMethod == "POST")
    #expect(urlRequest.allHTTPHeaderFields?["Content-Type"] == "application/json")
    #expect(urlRequest.httpBody == "body".data(using: .utf8))
}
