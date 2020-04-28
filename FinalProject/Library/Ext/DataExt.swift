//
//  DataExt.swift
//  FinalProject
//
//  Created by Sếp Quân on 4/28/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

extension Data {
    func tojson() -> JSObject {
        var json: [String: Any] = [:]
        do {
            if let jsonObj = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? JSObject {
                json = jsonObj
            }
        } catch {
            print("JSON casting error")
        }
        return json
    }
}
