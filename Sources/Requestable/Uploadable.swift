//
//  Uploadable.swift
//  Restofire
//
//  Created by Rahul Katariya on 30/01/18.
//  Copyright © 2018 AarKay. All rights reserved.
//

import Foundation

/// Represents an abstract `Uploadable` for Restofire.
///
/// Instead implement FileUploadable, DataUploadable, StreamUploadable,
/// MultipartUplodable protocols.
public protocol Uploadable: _AUploadable, DataResponseSerializable {
    
    /// Called when the Request succeeds.
    ///
    /// - parameter request: The Alamofire.UploadRequest
    /// - parameter value: The Response
    func request(_ request: UploadOperation<Self>, didCompleteWithValue value: Response)
    
    /// Called when the Request fails
    ///
    /// - parameter request: The Alamofire.UploadRequest
    /// - parameter error: The Error
    func request(_ request: UploadOperation<Self>, didFailWithError error: Error)
    
}

public extension Uploadable {
    
    /// `Does Nothing`
    func request(_ request: UploadOperation<Self>, didCompleteWithValue value: Response) {}
    
    /// `Does Nothing`
    func request(_ request: UploadOperation<Self>, didFailWithError error: Error) {}
    
    /// Creates a `UploadOperation` for the specified `Uploadable` object and
    /// asynchronously executes it.
    ///
    /// - parameter completionHandler: A closure to be executed once the download
    ///                                has finished. `nil` by default.
    ///
    /// - returns: The created `UploadOperation`.
    @discardableResult
    public func response(_ completionHandler: ((DataResponse<Response>) -> Void)? = nil) -> UploadOperation<Self> {
        let uploadOperation = UploadOperation(uploadable: self, request: request, completionHandler: completionHandler)
        uploadOperation.start()
        return uploadOperation
    }
    
}
