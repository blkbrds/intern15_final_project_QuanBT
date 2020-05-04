//
//  Team.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/3/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class Team {
    var idTeam: String
    var strTeam: String
    var strStadium: String
    var strTeamBadge: String
    var favorite: Bool = false
    
    init(json: JSObject = JSObject()) {
        self.idTeam = json["idTeam"] as? String ?? ""
        self.strTeam = json["strTeam"] as? String ?? ""
        self.strStadium = json["strStadium"] as? String ?? ""
        self.strTeamBadge = json["strTeamBadge"] as? String ?? ""
    }
}
