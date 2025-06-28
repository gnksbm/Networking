//
//  HTTPEventMonitor.swift
//  Networking
//
//  Created by gnksbm on 6/28/25.
//

public protocol HTTPEventMonitor {
    func didRequest(_ request: HTTPRequest)
    func didRecieve(_ request: HTTPRequest, httpURLResponse: HTTPResponse)
    func didError(_ request: HTTPRequest, error: Error)
}
