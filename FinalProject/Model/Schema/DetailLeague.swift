//
//  DetailLeague.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/3/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
 
final class DetailLeague {
    var idLeague: String
    var strLeague: String
    var intFormedYear: String
    var strCountry: String
    var strDescriptionEN: String
    var strWebsite: String
    var strFacebook: String
    var strTwitter: String
    var strYoutube: String
    var strLogo: String
    var strBadge: String
    var strPoster: String
    var strTrophy: String
    var strFanart1: String
    var strFanart2: String
    var strFanart3: String
    var strFanart4: String
    var favorite: Bool = false
    
    init(json: JSObject = JSObject()) {
        self.idLeague = json["idLeague"] as? String ?? ""
        self.strLeague = json["strLeague"] as? String ?? ""
        self.intFormedYear = json["intFormedYear"] as? String ?? "1998"
        self.strCountry = json["strCountry"] as? String ?? ""
        self.strDescriptionEN = json["strDescriptionEN"] as? String ?? ""
        self.strWebsite = json["strWebsite"] as? String ?? ""
        self.strFacebook = json["strFacebook"] as? String ?? ""
        self.strTwitter = json["strTwitter"] as? String ?? ""
        self.strYoutube = json["strYoutube"] as? String ?? ""
        self.strLogo = json["strLogo"] as? String ?? ""
        self.strBadge = json["strBadge"] as? String ?? ""
        self.strPoster = json["strPoster"] as? String ?? ""
        self.strTrophy = json["strTrophy"] as? String ?? ""
        self.strFanart1 = json["strFanart1"] as? String ?? ""
        self.strFanart2 = json["strFanart2"] as? String ?? ""
        self.strFanart3 = json["strFanart3"] as? String ?? ""
        self.strFanart4 = json["strFanart4"] as? String ?? ""
    }
}
