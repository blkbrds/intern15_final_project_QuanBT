//
//  App.swift
//  FinalProject
//
//  Created by MBA0176 on 4/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

struct App {
    struct Configuration {
    // MARK: Common
    static let dateformatYYYMMDD = "yyyy-MM-dd"
    static let dateformatYYYMMDDHHMMSS = "yyyy-MM-dd hh:mm:ss"
    static let dateformatYYYMMDDSlash = "yyyy/MM/dd"
    static let dateformatYYYMDSlash = "yyyy/M/d"
    static let dateformatYYYYMDSlash = "yyyy / M / d"
    static let dateformatYYYMDEEEEESlash = "yyyy/M/d(EEEEE)"
    static let dateformatMMddSlash = "MM/dd"
    static let dateformatMMdd = "MMdd"
    static let dateformatYYY = "yyyy"
    static let dateformatMDSlash = "M/d"
    static let dateformatMDEEEEESlash = "M/d(EEEEE)"
    static let dateformatMMDDEEEEESlash = "MM/dd(EEEEE)"
    static let dateformatISO8601 = "yyyy-MM-dd'T'HH:mm:ssZ"
    static let dateformatHMM = "H:mm"
    static let dateformaYYYYMM = "yyyy / MM"
    static let dateformatdd = "dd"
    }

    static let calendar = Calendar(identifier: .gregorian)
}
