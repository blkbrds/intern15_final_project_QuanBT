//
//  Team.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/3/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import RealmSwift

final class Team: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var stadium: String = ""
    @objc dynamic var badge: String = ""
    @objc dynamic var year: String = "1998"
    @objc dynamic var nameLeague: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var descriptions: String = ""
    @objc dynamic var facebook: String = ""
    @objc dynamic var youtube: String = ""
    @objc dynamic var twitter: String = ""
    @objc dynamic var website: String = ""
    @objc dynamic var jersey: String = ""
    @objc dynamic var logo: String = ""
    @objc dynamic var banner: String = ""
    @objc dynamic var fanart1: String = ""
    @objc dynamic var fanart2: String = ""
    @objc dynamic var fanart3: String = ""
    @objc dynamic var fanart4: String = ""
    var favorite: Bool = false
    
    convenience init(json: JSObject = JSObject()) {
        self.init()
        self.id = json["idTeam"] as? String ?? ""
        self.name = json["strTeam"] as? String ?? ""
        self.stadium = json["strStadium"] as? String ?? ""
        self.badge = json["strTeamBadge"] as? String ?? ""
        self.year = json["intFormedYear"] as? String ?? ""
        self.nameLeague = json["strLeague"] as? String ?? ""
        self.country = json["strCountry"] as? String ?? ""
        self.descriptions = json["strDescriptionEN"] as? String ?? ""
        self.facebook = json["strFacebook"] as? String ?? ""
        self.youtube = json["strYoutube"] as? String ?? ""
        self.twitter = json["strTwitter"] as? String ?? ""
        self.website = json["strWebsite"] as? String ?? ""
        self.jersey = json["strTeamJersey"] as? String ?? ""
        self.logo = json["strTeamLogo"] as? String ?? ""
        self.banner = json["strTeamBanner"] as? String ?? ""
        self.fanart1 = json["strTeamFanart1"] as? String ?? ""
        self.fanart2 = json["strTeamFanart2"] as? String ?? ""
        self.fanart3 = json["strTeamFanart3"] as? String ?? ""
        self.fanart4 = json["strTeamFanart4"] as? String ?? ""
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

enum Search {
    case team
    case player
}
