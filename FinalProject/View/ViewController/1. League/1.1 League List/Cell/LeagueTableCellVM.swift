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
    var dataFavorite: DetailLeague = DetailLeague()
    var isFavorite: Bool = false
    
    // MARK: - Init
    init(dataAPI: League = League(), dataFavorite: DetailLeague = DetailLeague(), favorite: Bool = false) {
        self.dataAPI = dataAPI
        self.dataFavorite = dataFavorite
        self.isFavorite = favorite
    }
    
    func addFavorite() {
        let data: DetailLeague = DetailLeague()
        data.id = dataAPI.id
        data.name = dataAPI.name
        data.logo = dataAPI.logo
        data.year = dataAPI.year
        RealmManager.shared.addObject(with: data)
    }
    
    func deleteFavorite() {
        guard let realm = RealmManager.shared.realm else { return }
        let result = realm.objects(DetailLeague.self).filter(NSPredicate(format: "id = %@", dataAPI.id))
        var data: [DetailLeague] = []
        data = Array(result)
        RealmManager.shared.deleteAllObject(with: data)
    }
}
