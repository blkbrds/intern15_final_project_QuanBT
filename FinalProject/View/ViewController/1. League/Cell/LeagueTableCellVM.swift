//
//  LeagueTableCellVM.swift
//  FinalProject
//
//  Created by Sếp Quân on 4/27/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class LeagueTableCellVM {
    // MARK: - Properties
    var dataAPI: League = League()
    
    // MARK: - Init
    init(dataAPI: League = League()) {
        self.dataAPI = dataAPI
    }
}
