//
//  RequestType.swift
//  Restofire
//
//  Created by Rahul Katariya on 24/03/16.
//  Copyright © 2016 AarKay. All rights reserved.
//

import Alamofire
import ReactiveCocoa

public extension RequestType {
    
    public func executeTask<Model: Any>() -> SignalProducer<Model, NSError> {
        
        return SignalProducer { sink, disposable in
            self.executeTask({ (result: Result<Model, NSError>) in
                if let error = result.error {
                    sink.sendFailed(error)
                } else {
                    sink.sendNext(result.value!)
                    sink.sendCompleted()
                }
            })
            
            disposable.addDisposable {
                
            }
        }
    }
    
}
