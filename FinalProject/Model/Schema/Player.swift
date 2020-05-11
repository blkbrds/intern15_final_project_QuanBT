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
    var favorite: Bool = false
    
    init(json: JSObject = JSObject()) {
        self.id = json["idPlayer"] as? String ?? ""
        self.name = json["strPlayer"] as? String ?? ""
        self.date = json["dateBorn"] as? String ?? ""
        self.thumb = json["strThumb"] as? String ?? ""
    }
}
