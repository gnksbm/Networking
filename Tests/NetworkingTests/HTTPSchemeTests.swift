//
//  HTTPSchemeTests.swift
//  Networking
//
//  Created by gnksbm on 6/28/25.
//

import Foundation
import Testing
@testable import Networking

@Test func testSchemeString() async throws {
    #expect(HTTPScheme.http.string == "http")
    #expect(HTTPScheme.https.string == "https")
    #expect(HTTPScheme.other("custom").string == "custom")
}
