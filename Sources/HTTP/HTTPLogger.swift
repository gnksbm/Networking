//
//  HTTPLogger.swift
//  Networking
//
//  Created by gnksbm on 6/28/25.
//

import Foundation

extension Data {
    var prettyPrintedString: String? {
        let data: Data
        if let object = try? JSONSerialization.jsonObject(with: self),
           JSONSerialization.isValidJSONObject(object),
            let _data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .withoutEscapingSlashes]) {
            data = _data
        } else {
            data = self
        }
        return String(data: data, encoding: .utf8)
    }
}

struct HTTPLogger: HTTPEventMonitor {
    func didRequest(_ request: any Networking.HTTPRequest) {
        let urlRequest = try? request.urlRequest
        print(
            """
            🚀
            - URL: \(String(describing: urlRequest?.url?.absoluteString))
            - Method: \(String(describing: urlRequest?.httpMethod))
            - Header: \(String(describing: urlRequest?.allHTTPHeaderFields))
            - Body: \(String(describing: urlRequest?.httpBody?.prettyPrintedString))
            """
        )
    }
    
    func didRecieve(_ request: any Networking.HTTPRequest, httpURLResponse: Networking.HTTPResponse) {
        let urlRequest = try? request.urlRequest
        print(
            """
            ✅
            - URL: \(String(describing: urlRequest?.url?.absoluteString))
            - Method: \(String(describing: urlRequest?.httpMethod))
            - StatusCode: \(httpURLResponse.httpURLResponse.statusCode)
            - Body: \(String(describing: httpURLResponse.data.prettyPrintedString))
            """
        )
    }
    
    func didError(_ request: any Networking.HTTPRequest, error: any Error) {
        let urlRequest = try? request.urlRequest
        print(
            """
            ❌
            - URL: \(String(describing: urlRequest?.url?.absoluteString))
            - Method: \(String(describing: urlRequest?.httpMethod))
            - Error: \(error.localizedDescription)
            """
        )
    }
}
