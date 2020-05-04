//
//  DetailLeague.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/3/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
 
final class DetailLeague {
    var id: String
    var name: String
    var year: String
    var country: String
    var description: String
    var website: String
    var facebook: String
    var twitter: String
    var youtube: String
    var logo: String
    var badge: String
    var poster: String
    var trophy: String
    var fanart1: String
    var fanart2: String
    var fanart3: String
    var fanart4: String
    var favorite: Bool = false
    
    init(json: JSObject = JSObject()) {
        self.id = json["idLeague"] as? String ?? ""
        self.name = json["strLeague"] as? String ?? ""
        self.year = json["intFormedYear"] as? String ?? "1998"
        self.country = json["strCountry"] as? String ?? ""
        self.description = json["strDescriptionEN"] as? String ?? ""
        self.website = json["strWebsite"] as? String ?? ""
        self.facebook = json["strFacebook"] as? String ?? ""
        self.twitter = json["strTwitter"] as? String ?? ""
        self.youtube = json["strYoutube"] as? String ?? ""
        self.logo = json["strLogo"] as? String ?? ""
        self.badge = json["strBadge"] as? String ?? ""
        self.poster = json["strPoster"] as? String ?? ""
        self.trophy = json["strTrophy"] as? String ?? ""
        self.fanart1 = json["strFanart1"] as? String ?? ""
        self.fanart2 = json["strFanart2"] as? String ?? ""
        self.fanart3 = json["strFanart3"] as? String ?? ""
        self.fanart4 = json["strFanart4"] as? String ?? ""
    }
}
