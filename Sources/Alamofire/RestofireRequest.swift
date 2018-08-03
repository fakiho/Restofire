//
//  Restofire.swift
//  Restofire
//
//  Created by Rahul Katariya on 19/04/16.
//  Copyright © 2016 AarKay. All rights reserved.
//

import Foundation
import Alamofire

class RestofireRequest {
    
    static func dataRequest<R: Requestable>(fromRequestable requestable: R, withUrlRequest urlRequest: URLRequest) -> DataRequest {
        let urlRequest = prepareRequest(urlRequest, requestable: requestable)
        let request = requestable.sessionManager.request(urlRequest)
        didSendRequest(request, requestable: requestable)
        authenticateRequest(request, usingCredential: requestable.credential)
        RestofireRequestValidation.validateDataRequest(request: request, requestable: requestable)
        return request
    }
    
    static func downloadRequest<R: Downloadable>(fromRequestable requestable: R, withUrlRequest urlRequest: URLRequest) -> DownloadRequest {
        let urlRequest = prepareDownloadRequest(urlRequest, requestable: requestable)
        let request = requestable.sessionManager.download(urlRequest, to: requestable.destination)
        didSendDownloadRequest(request, requestable: requestable)
        authenticateRequest(request, usingCredential: requestable.credential)
        RestofireDownloadValidation.validateDownloadRequest(request: request, requestable: requestable)
        return request
    }
    
    static func fileUploadRequest<R: FileUploadable>(fromRequestable requestable: R, withUrlRequest urlRequest: URLRequest) -> UploadRequest {
        let urlRequest = prepareRequest(urlRequest, requestable: requestable)
        let request = requestable.sessionManager.upload(requestable.url, with: urlRequest)
        didSendRequest(request, requestable: requestable)
        authenticateRequest(request, usingCredential: requestable.credential)
        RestofireUploadValidation.validateUploadRequest(request: request, requestable: requestable)
        return request
    }
    
    static func dataUploadRequest<R: DataUploadable>(fromRequestable requestable: R, withUrlRequest urlRequest: URLRequest) -> UploadRequest {
        let urlRequest = prepareRequest(urlRequest, requestable: requestable)
        let request = requestable.sessionManager.upload(requestable.data, with: urlRequest)
        didSendRequest(request, requestable: requestable)
        authenticateRequest(request, usingCredential: requestable.credential)
        RestofireUploadValidation.validateUploadRequest(request: request, requestable: requestable)
        return request
    }
    
    static func streamUploadRequest<R: StreamUploadable>(fromRequestable requestable: R, withUrlRequest urlRequest: URLRequest) -> UploadRequest {
        let urlRequest = prepareRequest(urlRequest, requestable: requestable)
        let request = requestable.sessionManager.upload(requestable.stream, with: urlRequest)
        didSendRequest(request, requestable: requestable)
        authenticateRequest(request, usingCredential: requestable.credential)
        RestofireUploadValidation.validateUploadRequest(request: request, requestable: requestable)
        return request
    }
    
    static func multipartUploadRequest<R: MultipartUploadable>(fromRequestable requestable: R, withUrlRequest urlRequest: URLRequest, encodingCompletion: ((RFMultipartFormDataEncodingResult) -> Void)? = nil) {
        let urlRequest = prepareRequest(urlRequest, requestable: requestable)
        let multipartUploadRequest = MultipartUploadRequest()
        multipartUploadRequest.request(fromRequestable: requestable, withUrlRequest: urlRequest, encodingCompletion: encodingCompletion)
    }
    
    internal static func authenticateRequest(_ request: Request, usingCredential credential: URLCredential?) {
        guard let credential = credential else { return }
        request.authenticate(usingCredential: credential)
    }
    
    internal static func prepareRequest<R: BaseRequestable>(_ request: URLRequest, requestable: R) -> URLRequest {
        var request = request
        requestable.delegates.forEach {
            request = $0.prepare(request, requestable: requestable)
        }
        request = requestable.prepare(request, requestable: requestable)
        return request
    }
    
    internal static func didSendRequest<R: BaseRequestable>(_ request: Request, requestable: R) {
        requestable.delegates.forEach {
            $0.didSend(request, requestable: requestable)
        }
        requestable.didSend(request, requestable: requestable)
    }
    
    internal static func prepareDownloadRequest<R: BaseDownloadable>(_ request: URLRequest, requestable: R) -> URLRequest {
        var request = request
        requestable.delegates.forEach {
            request = $0.prepare(request, requestable: requestable)
        }
        request = requestable.prepare(request, requestable: requestable)
        return request
    }
    
    internal static func didSendDownloadRequest<R: BaseDownloadable>(_ request: Request, requestable: R) {
        requestable.delegates.forEach {
            $0.didSend(request, requestable: requestable)
        }
        requestable.didSend(request, requestable: requestable)
    }
    
}
