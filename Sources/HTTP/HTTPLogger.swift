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
        guard let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            return nil
        }
        return prettyPrintedString as String
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
        let mimeType = httpURLResponse.httpURLResponse.mimeType?.lowercased() ?? ""
        let responseData = httpURLResponse.data
        
        let encoding: String.Encoding = {
            if let name = httpURLResponse.httpURLResponse.textEncodingName {
                let cfEnc = CFStringConvertIANACharSetNameToEncoding(name as CFString)
                let nsEnc = CFStringConvertEncodingToNSStringEncoding(cfEnc)
                return String.Encoding(rawValue: nsEnc)
            } else {
                return .utf8
            }
        }()
        
        var bodyString: String?
        if mimeType == "application/json" {
            bodyString = responseData.prettyPrintedString
        } else if mimeType.hasPrefix("text/") || mimeType.contains("xml") {
            bodyString = String(data: responseData, encoding: encoding)
        }
        
        print(
            """
            ✅
            - URL: \(String(describing: urlRequest?.url?.absoluteString))
            - Method: \(String(describing: urlRequest?.httpMethod))
            - StatusCode: \(httpURLResponse.httpURLResponse.statusCode)
            - Body: \(String(describing: bodyString))
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
