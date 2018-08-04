//
//  ResponseSerializer.swift
//  Restofire
//
//  Created by Rahul Katariya on 29/01/18.
//  Copyright © 2018 AarKay. All rights reserved.
//

import Foundation
import Alamofire

/// Represents a `Alamofire.DataResponseSerializer` that is associated with `Requestable`.
public extension ResponseSerializer where SerializedObject == Data {
    
    public func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) throws -> SerializedObject {
        return try DataResponseSerializer().serialize(request: request, response: response, data: data, error: error)
    }
    
    public func serializeDownload(request: URLRequest?, response: HTTPURLResponse?, fileURL: URL?, error: Error?) throws -> SerializedObject {
        return try DataResponseSerializer().serializeDownload(request: request, response: response, fileURL: fileURL, error: error)
    }
    
}
