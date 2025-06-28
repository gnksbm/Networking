//
//  HTTPMethodTests.swift
//  Networking
//
//  Created by gnksbm on 6/28/25.
//

import Foundation
import Testing
@testable import Networking

@Test func testHTTPMethodString() async throws {
    #expect(HTTPMethod.get.string == "GET")
    #expect(HTTPMethod.post.string == "POST")
    #expect(HTTPMethod.put.string == "PUT")
    #expect(HTTPMethod.patch.string == "PATCH")
    #expect(HTTPMethod.delete.string == "DELETE")
}
