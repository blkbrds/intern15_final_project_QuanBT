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
    var favorite: Bool = false
    
    init(json: JSObject = JSObject()) {
        self.id = json["idTeam"] as? String ?? ""
        self.name = json["strTeam"] as? String ?? ""
        self.stadium = json["strStadium"] as? String ?? ""
        self.badge = json["strTeamBadge"] as? String ?? ""
    }
}
