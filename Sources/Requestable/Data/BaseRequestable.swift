//
//  DataRequestable.swift
//  Restofire
//
//  Created by RahulKatariya on 03/08/18.
//  Copyright © 2018 AarKay. All rights reserved.
//

import Foundation

public protocol BaseRequestable: _Requestable, Configurable, RequestDelegate {
    
    /// The request delegates.
    var delegates: [RequestDelegate] { get }
    
}

extension BaseRequestable {
    
    /// `empty`
    public var delegates: [RequestDelegate] {
        return configuration.requestDelegates
    }
    
}
