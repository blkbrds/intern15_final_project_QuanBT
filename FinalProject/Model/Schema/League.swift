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
        self.intFormedYear = json["intFormedYear"] as? String ?? ""
        self.strLogo = json["strLogo"] as? String ?? ""
    }
}

