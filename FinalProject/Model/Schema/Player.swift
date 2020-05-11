//
//  Player.swift
//  FinalProject
//
//  Created by MBA0176 on 4/25/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class Player {
    var id: String
    var name: String
    var date: String
    var thumb: String
    var idTeam: String
    var nationality: String
    var number: String
    var description: String
    var position: String
    var facebook: String
    var youtube: String
    var twitter: String
    var website: String
    var height: String
    var weight: String
    var cutout: String
    var banner: String
    var fanart1: String
    var fanart2: String
    var fanart3: String
    var fanart4: String
    var favorite: Bool = false
    
    init(json: JSObject = JSObject()) {
        self.id = json["idPlayer"] as? String ?? ""
        self.name = json["strPlayer"] as? String ?? ""
        self.date = json["dateBorn"] as? String ?? ""
        self.thumb = json["strThumb"] as? String ?? ""
        self.idTeam = json["idTeam"] as? String ?? ""
        self.nationality = json["strNationality"] as? String ?? ""
        self.number = json["strNumber"] as? String ?? ""
        self.description = json["strDescriptionEN"] as? String ?? ""
        self.position = json["strPosition"] as? String ?? ""
        self.facebook = json["strFacebook"] as? String ?? ""
        self.youtube = json["strYoutube"] as? String ?? ""
        self.twitter = json["strTwitter"] as? String ?? ""
        self.website = json["strWebsite"] as? String ?? ""
        self.height = json["strHeight"] as? String ?? ""
        self.weight = json["strWeight"] as? String ?? ""
        self.cutout = json["strCutout"] as? String ?? ""
        self.banner = json["strBanner"] as? String ?? ""
        self.fanart1 = json["strFanart1"] as? String ?? ""
        self.fanart2 = json["strFanart2"] as? String ?? ""
        self.fanart3 = json["strFanart3"] as? String ?? ""
        self.fanart4 = json["strFanart4"] as? String ?? ""
    }
}
