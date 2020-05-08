//
//  PlayerHeaderVM.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/8/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class PlayerHeaderVM {
    // MARK: - Properties
    var dataAPI: Player = Player()
    var teamAPI: Team = Team()
    
    // MARK: - Init
    init(dataAPI: Player = Player(), teamAPI: Team = Team()) {
        self.dataAPI = dataAPI
        self.teamAPI = teamAPI
    }
}
