//
//  RequestDelegate.swift
//  Restofire
//
//  Created by Rahul Katariya on 05/02/18.
//  Copyright © 2018 AarKay. All rights reserved.
//

import Foundation

/// Represents a `RequestDelegate` that is associated with `Requestable`.
public protocol RequestDelegate {
    
    /// Called to modify a request before sending.
    func prepare(_ request: URLRequest, requestable: BaseRequestable) -> URLRequest
    
    /// Called when the request is sent over the network.
    func didSend(_ request: Request, requestable: BaseRequestable)
    
    /// Called before the request is transformed to `Requestable`.Response.
    func process(_ request: Request, requestable: BaseRequestable, response: DefaultDataResponse) -> DefaultDataResponse
    
}

extension RequestDelegate {

    /// `No-op`
    public func prepare(_ request: URLRequest, requestable: BaseRequestable) -> URLRequest {
        return request
    }

    /// `No-op`
    public func didSend(_ request: Request, requestable: BaseRequestable) {}
    
    /// `No-op`
    public func process(_ request: Request, requestable: BaseRequestable, response: DefaultDataResponse) -> DefaultDataResponse {
        return response
    }

}
