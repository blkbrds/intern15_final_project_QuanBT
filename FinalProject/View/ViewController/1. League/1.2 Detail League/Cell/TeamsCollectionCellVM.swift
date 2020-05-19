//
//  TeamsCollectionCellVM.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/1/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class TeamsCollectionCellVM {
    // MARK: - Properties
    var dataAPI: Team = Team()
    
    // MARK: - Init
    init(dataAPI: Team = Team()) {
        self.dataAPI = dataAPI
    }
    
    func addFavorite() {
        let data: Team = Team()
        data.id = dataAPI.id
        data.name = dataAPI.name
        data.badge = dataAPI.badge
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
