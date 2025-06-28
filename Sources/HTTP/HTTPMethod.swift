//
//  HTTPMethod.swift
//  Networking
//
//  Created by gnksbm on 6/28/25.
//

public enum HTTPMethod: String {
    case get, put, post, patch, delete
    
    public var string: String {
        rawValue.uppercased()
    }
}
