//
//  Requestable.swift
//  Restofire
//
//  Created by Rahul Katariya on 24/03/16.
//  Copyright © 2016 AarKay. All rights reserved.
//

import Foundation

/// Represents a `Requestable` for Restofire.
///
/// ### Create custom Requestable
/// ```swift
/// protocol HTTPBinGETService: Requestable {
///
///     var path: String? = "get"
///
/// }
/// ```
public protocol Requestable: BaseRequestable, DataResponseSerializable {

    /// The Alamofire data request validation.
    var validationBlock: DataRequest.Validation? { get }
    
    /// Called when the Request succeeds.
    ///
    /// - parameter request: The Alamofire.DataRequest
    /// - parameter error: The Response
    func request(_ request: RequestOperation<Self>, didCompleteWithValue value: Response)
    
    /// Called when the Request fails.
    ///
    /// - parameter request: The Alamofire.DataRequest
    /// - parameter error: The Error
    func request(_ request: RequestOperation<Self>, didFailWithError error: Error)
    
}

public extension Requestable {
    
    /// `Validation.default.dataValidation`
    public var validationBlock: DataRequest.Validation? {
        return validation.dataValidation
    }
    
    /// Creates a `DataRequest` to retrieve the contents of a URL based on the specified `Requestable`
    ///
    /// If `startRequestsImmediately` is `true`, the request will have `resume()` called before being returned.
    ///
    /// - returns: The created `DataRequest`.
    public var request: DataRequest {
        return RestofireRequest.dataRequest(fromRequestable: self, withUrlRequest: urlRequest)
    }
    
    /// `Does Nothing`
    func request(_ request: RequestOperation<Self>, didCompleteWithValue value: Response) {}
    
    /// `Does Nothing`
    func request(_ request: RequestOperation<Self>, didFailWithError error: Error) {}
    
}

public extension Requestable {
    
    /// Creates a `RequestOperation` for the specified `Requestable` object and
    /// asynchronously executes it.
    ///
    /// - parameter completionHandler: A closure to be executed once the request
    ///                                has finished. `nil` by default.
    ///
    /// - returns: The created `RequestOperation`.
    @discardableResult
    public func execute(completionHandler: ((DataResponse<Response>) -> Void)? = nil) -> RequestOperation<Self> {
        return execute(request: self.request, completionHandler: completionHandler)
    }
    
    /// Creates a `RequestOperation` for the specified `Requestable` object and
    /// asynchronously executes it.
    ///
    /// - parameter request: A data request instance
    /// - parameter completionHandler: A closure to be executed once the request
    ///                                has finished. `nil` by default.
    ///
    /// - returns: The created `RequestOperation`.
    @discardableResult
    public func execute(request: @autoclosure @escaping () -> DataRequest, completionHandler: ((DataResponse<Response>) -> Void)? = nil) -> RequestOperation<Self> {
        let requestOperation = RequestOperation(requestable: self, request: request, completionHandler: completionHandler)
        requestOperation.start()
        return requestOperation
    }
    
}
