//
//  League.swift
//  FinalProject
//
//  Created by Sếp Quân on 4/28/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import UIKit
 
final class League {
    var idLeague: String
    var strLeague: String
    var intFormedYear: String
    var strLogo: String
    var favorite: Bool = false
    var thumbnailImage: UIImage?
    
    init(json: JSObject = JSObject()) {
        self.idLeague = json["idLeague"] as? String ?? ""
        self.strLeague = json["strLeague"] as? String ?? ""
        self.intFormedYear = json["intFormedYear"] as? String ?? "1998"
        self.strLogo = json["strLogo"] as? String ?? ""
    }
}

enum Sport: String {
    case soccer = "Soccer"
    case motorsport = "Motorsport"
    case fighting = "Fighting"
    
    var country: [Country] {
        switch self {
        case .soccer:
            return [.england, .germany, .italy, .spain]
        case .motorsport:
            return [.worldwide, .usa, .international, .england]
        case .fighting:
            return [.worldwide, .japan, .europe, .usa]
        }
    }
}

enum Country: String {
    case england = "England"
    case germany = "Germany"
    case italy = "Italy"
    case spain = "Spain"
    case worldwide = "Worldwide"
    case usa = "USA"
    case international = "International"
    case europe = "Europe"
    case japan = "Japan"
    
    var flag: UIImage {
        switch self {
        case .england:
            return #imageLiteral(resourceName: "img-England")
        case .germany:
            return #imageLiteral(resourceName: "img-Germany")
        case .italy:
            return #imageLiteral(resourceName: "img-Italia")
        case .spain:
            return #imageLiteral(resourceName: "img-Spain")
        case .worldwide:
            return #imageLiteral(resourceName: "img-World")
        case .usa:
            return #imageLiteral(resourceName: "img-USA")
        case .international:
            return #imageLiteral(resourceName: "ic-international")
        case .europe:
            return #imageLiteral(resourceName: "img-Europe")
        case .japan:
            return #imageLiteral(resourceName: "img-Japan")
        }
    }
}
