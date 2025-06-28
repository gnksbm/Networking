//
//  HTTPScheme.swift
//  Networking
//
//  Created by gnksbm on 6/28/25.
//

public enum HTTPScheme {
    case http
    case https
    case other(_ value: String)
    
    var string: String {
        switch self {
        case .http:
            "http"
        case .https:
            "https"
        case let .other(value):
            value
        }
    }
}
