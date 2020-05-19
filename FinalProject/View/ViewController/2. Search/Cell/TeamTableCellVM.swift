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
    
    func addFavorite() {
        let data: Team = Team()
        data.id = dataAPI.id
        data.name = dataAPI.name
        data.logo = dataAPI.logo
        data.stadium = dataAPI.stadium
        RealmManager.shared.addObject(with: data)
    }
    
    func deleteFavorite() {
        guard let realm = RealmManager.shared.realm else { return }
        let result = realm.objects(Team.self).filter(NSPredicate(format: "id = %@", dataAPI.id))
        var data: [Team] = []
        data = Array(result)
        RealmManager.shared.deleteAllObject(with: data)
    }
}
