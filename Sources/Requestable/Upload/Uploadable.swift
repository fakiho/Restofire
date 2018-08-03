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
public protocol Uploadable: BaseRequestable, DataResponseSerializable {

    /// The uplaod request for subclasses to provide the implementation.
    var request: UploadRequest { get }
    
    /// The Alamofire data request validation.
    var validationBlock: DataRequest.Validation? { get }
    
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
    
    /// `.post`
    public var method: HTTPMethod {
        return .post
    }
    
    /// `Validation.default.dataValidation`
    public var validationBlock: DataRequest.Validation? {
        return validation.dataValidation
    }
    
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
    public func execute(completionHandler: ((DataResponse<Response>) -> Void)? = nil) -> UploadOperation<Self> {
        return execute(request: self.request, completionHandler: completionHandler)
    }
    
    /// Creates a `UploadOperation` for the specified `Uploadable` object and
    /// asynchronously executes it.
    ///
    /// - parameter request: An upload request instance
    /// - parameter completionHandler: A closure to be executed once the download
    ///                                has finished. `nil` by default.
    ///
    /// - returns: The created `UploadOperation`.
    @discardableResult
    public func execute(request: @autoclosure @escaping () -> UploadRequest, completionHandler: ((DataResponse<Response>) -> Void)? = nil) -> UploadOperation<Self> {
        let uploadOperation = UploadOperation(uploadable: self, request: request, completionHandler: completionHandler)
        uploadOperation.start()
        return uploadOperation
    }
    
}
