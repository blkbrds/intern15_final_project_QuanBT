//
//  PlayerTableCellVM.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/6/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class PlayerTableCellVM {
    // MARK: - Properties
    var dataAPI: Player = Player()
    var isFavorite: Bool = false
    
    // MARK: - Init
    init(dataAPI: Player = Player(), favorite: Bool = false) {
        self.dataAPI = dataAPI
        self.isFavorite = favorite
    }
    
    func addFavorite() {
        let data: Player = Player()
        data.id = dataAPI.id
        data.name = dataAPI.name
        data.cutout = dataAPI.cutout
        data.date = dataAPI.date
        RealmManager.shared.addObject(with: data)
    }
    
    func deleteFavorite() {
        guard let realm = RealmManager.shared.realm else { return }
        let result = realm.objects(Player.self).filter(NSPredicate(format: "id = %@", dataAPI.id))
        var data: [Player] = []
        data = Array(result)
        RealmManager.shared.deleteAllObject(with: data)
    }
}
