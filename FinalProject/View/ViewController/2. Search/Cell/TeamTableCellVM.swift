//
//  TeamTableCellVM.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/6/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class TeamTableCellVM {
    // MARK: - Properties
    var dataAPI: Team = Team()
    var isFavorite: Bool = false
    
    // MARK: - Init
    init(dataAPI: Team = Team(), favorite: Bool = false) {
        self.dataAPI = dataAPI
        self.isFavorite = favorite 
    }
}
