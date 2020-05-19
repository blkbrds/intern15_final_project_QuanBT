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
    var id: String
    var name: String
    var year: String
    var logo: String
    var isFavorite: Bool = false
    var logoImage: UIImage?
    
    init(json: JSObject = JSObject()) {
        self.id = json["idLeague"] as? String ?? ""
        self.name = json["strLeague"] as? String ?? ""
        self.year = json["intFormedYear"] as? String ?? "1998"
        self.logo = json["strLogo"] as? String ?? ""
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
    case argentine = "Argentine"
    case brazil = "Brazil"
    case australia = "Australia"
    case canada = "Canada"
    case chile = "Chile"
    case china = "China"
    case colombia = "Colombia"
    
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
        case .argentine:
            return #imageLiteral(resourceName: "img-Argentine")
        case .brazil:
            return #imageLiteral(resourceName: "img-Brazil")
        case .australia:
            return #imageLiteral(resourceName: "img-Australia")
        case .canada:
            return #imageLiteral(resourceName: "img-Canada")
        case .chile:
            return #imageLiteral(resourceName: "img-Chile")
        case .china:
            return #imageLiteral(resourceName: "img-China")
        case .colombia:
            return #imageLiteral(resourceName: "img-Colombia")
        }
    }
}
