//
//  BaseDownloadable.swift
//  Restofire
//
//  Created by RahulKatariya on 03/08/18.
//  Copyright © 2018 AarKay. All rights reserved.
//

import Foundation

public protocol BaseDownloadable: _Requestable, Configurable, DownloadDelegate {
    
    /// The request delegates.
    var delegates: [DownloadDelegate] { get }
    
}

extension BaseDownloadable {
    
    /// `empty`
    public var delegates: [DownloadDelegate] {
        return configuration.downloadDelegates
    }
    
}
