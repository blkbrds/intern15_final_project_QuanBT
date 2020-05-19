//
//  LeagueCollectionCellVM.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/11/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class LeagueCollectionCellVM {
    var dataLeague: DetailLeague = DetailLeague()
    var dataTeam: Team = Team()
    var dataPlayer: Player = Player()
    var index: Int = 0
    
    init(dataLeagues: DetailLeague = DetailLeague(), dataTeams: Team = Team(), dataPlayers: Player = Player(), index: Int = 0) {
        self.dataLeague = dataLeagues
        self.dataTeam = dataTeams
        self.dataPlayer = dataPlayers
        self.index = index
    }
}
