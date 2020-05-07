//
//  LeagueHeaderCellVM.swift
//  FinalProject
//
//  Created by Sếp Quân on 4/29/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class LeagueHeaderCellVM {
    // MARK: - Properties
    var dataAPI: DetailLeague = DetailLeague()
    
    // MARK: - Init
    init(dataAPI: DetailLeague = DetailLeague()) {
        self.dataAPI = dataAPI
    }
}
