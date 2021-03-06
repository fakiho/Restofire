//
//  ArrayParameterEncodingSpec.swift
//  Restofire-iOS
//
//  Created by Rahul Katariya on 31/01/18.
//  Copyright © 2018 AarKay. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Alamofire
@testable import Restofire

class ArrayParameterEncodingSpec: BaseSpec {
    
    override func spec() {
        
        describe("ArrayParameterEncoding") {
            it("should encode request with array of Any") {
                struct Service: _Requestable {
                    var path: String? = "get"
                    var parameters: Any? = ["foo","baz"]
                }
                
                let urlRequest = Service().urlRequest
                let body = urlRequest.httpBody!
                let params = String(data: body, encoding: .utf8)!
                expect(params).to(equal("[\"foo\",\"baz\"]"))
            }
        }
        
    }
    
}
