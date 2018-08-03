//
//  DownloadOperation.swift
//  Restofire
//
//  Created by Rahul Katariya on 28/01/18.
//  Copyright © 2018 AarKay. All rights reserved.
//

import Foundation

/// An NSOperation that executes the `Downloadable` asynchronously.
public class DownloadOperation<R: Downloadable>: AOperation<R> {
    
    let downloadable: R
    let downloadRequest: () -> DownloadRequest
    let completionHandler: ((DownloadResponse<R.Response>) -> Void)?
    
    /// Intializes an download operation.
    ///
    /// - Parameters:
    ///   - downloadable: The `Downloadable`.
    ///   - request: The request closure.
    ///   - completionHandler: The async completion handler called
    ///     when the request is completed
    public init(downloadable: R, request: @escaping (() -> DownloadRequest), completionHandler: ((DownloadResponse<R.Response>) -> Void)?) {
        self.downloadable = downloadable
        self.downloadRequest = request
        self.completionHandler = completionHandler
        super.init(configurable: downloadable, request: request)
    }
    
    override func handleDownloadResponse(_ response: DefaultDownloadResponse) {
        let request = self.request as! DownloadRequest
        var res = response
        
        downloadable.delegates.forEach {
            res = $0.process(request, requestable: downloadable, response: res)
        }
        res = downloadable.process(request, requestable: downloadable, response: res)
        
        let result = downloadable.responseSerializer.serializeResponse(
            res.request,
            res.response,
            res.temporaryURL,
            res.error
        )
        
        let downloadResponse = DownloadResponse<R.Response>(
            request: res.request,
            response: res.response,
            temporaryURL: res.temporaryURL,
            destinationURL: res.destinationURL,
            resumeData: res.resumeData,
            result: result
        )
        
        downloadable.queue.async {
            self.completionHandler?(downloadResponse)
        }
        
        if let error = res.error {
            self.downloadable.request(self, didFailWithError: error)
        } else {
            self.downloadable.request(self, didCompleteWithValue: downloadResponse.value!)
        }
        
        self.isFinished = true
        
    }
    
    /// Creates a copy of self
    open override func copy() -> AOperation<R> {
        return DownloadOperation(
            downloadable: downloadable,
            request: downloadRequest,
            completionHandler: completionHandler
        )
    }
    
}
