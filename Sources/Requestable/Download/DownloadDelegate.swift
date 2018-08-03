//
//  DownloadDelegate.swift
//  Restofire
//
//  Created by Rahul Katariya on 05/02/18.
//  Copyright © 2018 AarKay. All rights reserved.
//

import Foundation

/// Represents a `DownloadDelegate` that is associated with `Requestable`.
public protocol DownloadDelegate {
    
    /// Called to modify a request before sending.
    func prepare(_ request: URLRequest, requestable: BaseDownloadable) -> URLRequest
    
    /// Called when the request is sent over the network.
    func didSend(_ request: Request, requestable: BaseDownloadable)
    
    /// Called before the request is transformed to `Downloadable`.Response.
    func process(_ request: Request, requestable: BaseDownloadable, response: DefaultDownloadResponse) -> DefaultDownloadResponse
    
}

extension DownloadDelegate {
    
    /// `No-op`
    public func prepare(_ request: URLRequest, requestable: BaseDownloadable) -> URLRequest {
        return request
    }
    
    /// `No-op`
    public func didSend(_ request: Request, requestable: BaseDownloadable) {}
    
    /// `No-op`
    public func process(_ request: Request, requestable: BaseDownloadable, response: DefaultDownloadResponse) -> DefaultDownloadResponse {
        return response
    }
    
}
