//
//  HTTPResponseTests.swift
//  Networking
//
//  Created by gnksbm on 6/28/25.
//

import Foundation
import Testing
@testable import Networking

@Test func testValidateSuccessStatusCodeSuccess() async throws {
    let urlResponse = HTTPURLResponse(
        url: URL(string: "https://example.com")!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
    )!
    let response = HTTPResponse(data: Data(), httpURLResponse: urlResponse)
    try response.validateSuccessStatusCode()
}

@Test func testValidateSuccessStatusCodeFailure() async throws {
    let urlResponse = HTTPURLResponse(
        url: URL(string: "https://example.com")!,
        statusCode: 404,
        httpVersion: nil,
        headerFields: nil
    )!
    let response = HTTPResponse(data: Data(), httpURLResponse: urlResponse)
    #expect(throws: URLError(.badServerResponse)) {
        try response.validateSuccessStatusCode()
    }
}
