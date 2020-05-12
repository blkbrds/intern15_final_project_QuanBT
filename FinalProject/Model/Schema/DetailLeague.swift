//
//  DetailLeague.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/3/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import RealmSwift
 
final class DetailLeague: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var year: String = "1998"
    @objc dynamic var country: String = ""
    @objc dynamic var descriptionEN: String = ""
    @objc dynamic var website: String = ""
    @objc dynamic var facebook: String = ""
    @objc dynamic var twitter: String = ""
    @objc dynamic var youtube: String = ""
    @objc dynamic var logo: String = ""
    @objc dynamic var badge: String = ""
    @objc dynamic var poster: String = ""
    @objc dynamic var trophy: String = ""
    @objc dynamic var fanart1: String = ""
    @objc dynamic var fanart2: String = ""
    @objc dynamic var fanart3: String = ""
    @objc dynamic var fanart4: String = ""
    var favorite: Bool = false
    
    convenience init(json: JSObject = JSObject()) {
        self.init()
        self.id = json["idLeague"] as? String ?? ""
        self.name = json["strLeague"] as? String ?? ""
        self.year = json["intFormedYear"] as? String ?? "1998"
        self.country = json["strCountry"] as? String ?? ""
        self.descriptionEN = json["strDescriptionEN"] as? String ?? ""
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
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
