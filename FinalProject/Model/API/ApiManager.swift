//
//  ApiManager.swift
//  FinalProject
//
//  Created by MBA0176 on 4/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import Alamofire

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]

typealias CompletionAPI = (Bool, String) -> Void
typealias Completion = (Result<Any>) -> Void
typealias APICompletion = (APIResult) -> Void
typealias DataCompletion<Value> = (Result<Value>) -> Void
typealias ProcessCompletion = () -> Void

enum APIResult {
    case success
    case failure(Error)
}

let api = ApiManager()

final class ApiManager {

    var defaultHTTPHeaders: [String: String] {
        let headers: [String: String] = [:]
        return headers
    }
}
