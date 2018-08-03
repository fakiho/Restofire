//
//  Downloadable.swift
//  Restofire
//
//  Created by Rahul Katariya on 30/01/18.
//  Copyright © 2018 AarKay. All rights reserved.
//

import Foundation

/// Represents a `Downloadable` for Restofire.
///
/// ```swift
/// protocol HTTPBinDownloadService: Downloadable {
///
///     var path: String? = "bytes/\(4 * 1024 * 1024)"
///     var destination: DownloadFileDestination?
///
///     init(destination: @escaping DownloadFileDestination) {
///         self.destination = destination
///     }
///
/// }
/// ```
public protocol Downloadable: BaseDownloadable, DownloadResponseSerializable {

    /// The download file destination
    var destination: DownloadFileDestination? { get }
    
    /// The Alamofire data request validation.
    var validationBlock: DownloadRequest.Validation? { get }
    
    /// Called when the Request succeeds.
    ///
    /// - parameter request: The Alamofire.DownloadRequest
    /// - parameter value: The Response
    func request(_ request: DownloadOperation<Self>, didCompleteWithValue value: Response)
    
    /// Called when the Request fails
    ///
    /// - parameter request: The Alamofire.DownloadRequest
    /// - parameter error: The Error
    func request(_ request: DownloadOperation<Self>, didFailWithError error: Error)
    
}

public extension Downloadable {
    
    /// `nil`
    public var destination: DownloadFileDestination? {
        return nil
    }
    
    /// `Validation.default.downloadValidation`
    public var validationBlock: DownloadRequest.Validation? {
        return validation.downloadValidation
    }
    
    /// Creates a `DownloadRequest` to retrieve the contents of a URL based on the specified `Requestable`
    ///
    /// If `startRequestsImmediately` is `true`, the request will have `resume()` called before being returned.
    ///
    /// - returns: The created `DownloadRequest`.
    public var request: DownloadRequest {
        return RestofireRequest.downloadRequest(fromRequestable: self, withUrlRequest: urlRequest)
    }
    
    /// `Does Nothing`
    func request(_ request: DownloadOperation<Self>, didCompleteWithValue value: Response) {}
    
    /// `Does Nothing`
    func request(_ request: DownloadOperation<Self>, didFailWithError error: Error) {}
    
}

public extension Downloadable {
    
    /// Creates a `DownloadOperation` for the specified `Requestable` object and
    /// asynchronously executes it.
    ///
    /// - parameter completionHandler: A closure to be executed once the download
    ///                                has finished. `nil` by default.
    ///
    /// - returns: The created `DownloadOperation`.
    @discardableResult
    public func execute(completionHandler: ((DownloadResponse<Response>) -> Void)? = nil) -> DownloadOperation<Self> {
        return execute(request: self.request, completionHandler: completionHandler)
    }
    
    /// Creates a `DownloadOperation` for the specified `Requestable` object and
    /// asynchronously executes it.
    ///
    /// - parameter request: A download request instance
    /// - parameter completionHandler: A closure to be executed once the download
    ///                                has finished. `nil` by default.
    ///
    /// - returns: The created `DownloadOperation`.
    @discardableResult
    public func execute(request: @autoclosure @escaping () -> DownloadRequest, completionHandler: ((DownloadResponse<Response>) -> Void)? = nil) -> DownloadOperation<Self> {
        let downloadOperation = DownloadOperation(downloadable: self, request: request, completionHandler: completionHandler)
        downloadOperation.start()
        return downloadOperation
    }
    
}
