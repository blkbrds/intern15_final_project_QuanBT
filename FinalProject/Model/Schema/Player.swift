//
//  Player.swift
//  FinalProject
//
//  Created by MBA0176 on 4/25/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import RealmSwift

final class Player: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var thumb: String = ""
    @objc dynamic var idTeam: String = ""
    @objc dynamic var nationality: String = ""
    @objc dynamic var number: String = ""
    @objc dynamic var descriptions: String = ""
    @objc dynamic var position: String = ""
    @objc dynamic var facebook: String = ""
    @objc dynamic var youtube: String = ""
    @objc dynamic var twitter: String = ""
    @objc dynamic var website: String = ""
    @objc dynamic var height: String = ""
    @objc dynamic var weight: String = ""
    @objc dynamic var cutout: String = ""
    @objc dynamic var banner: String = ""
    @objc dynamic var fanart1: String = ""
    @objc dynamic var fanart2: String = ""
    @objc dynamic var fanart3: String = ""
    @objc dynamic var fanart4: String = ""
    var favorite: Bool = false
    
    convenience init(json: JSObject = JSObject()) {
        self.init()
        self.id = json["idPlayer"] as? String ?? ""
        self.name = json["strPlayer"] as? String ?? ""
        self.date = json["dateBorn"] as? String ?? ""
        self.thumb = json["strThumb"] as? String ?? ""
        self.idTeam = json["idTeam"] as? String ?? ""
        self.nationality = json["strNationality"] as? String ?? ""
        self.number = json["strNumber"] as? String ?? ""
        self.descriptions = json["strDescriptionEN"] as? String ?? ""
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
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
