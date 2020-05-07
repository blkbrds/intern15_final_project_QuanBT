//
//  Team.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/3/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class Team {
    var id: String
    var name: String
    var stadium: String
    var badge: String
    var year: String
    var nameLeague: String
    var country: String
    var description: String
    var facebook: String
    var youtube: String
    var twitter: String
    var website: String
    var jersey: String
    var logo: String
    var banner: String
    var fanart1: String
    var fanart2: String
    var fanart3: String
    var fanart4: String
    var favorite: Bool = false
    
    init(json: JSObject = JSObject()) {
        self.id = json["idTeam"] as? String ?? ""
        self.name = json["strTeam"] as? String ?? ""
        self.stadium = json["strStadium"] as? String ?? ""
        self.badge = json["strTeamBadge"] as? String ?? ""
        self.year = json["intFormedYear"] as? String ?? ""
        self.nameLeague = json["strLeague"] as? String ?? ""
        self.country = json["strCountry"] as? String ?? ""
        self.description = json["strDescriptionEN"] as? String ?? ""
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
}

enum Search {
    case team
    case player
}
