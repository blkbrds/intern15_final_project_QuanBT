//
//  PlayerViewModel.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/8/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class PlayerViewModel {
    // MARK: - Properties
    var dataAPI: Player = Player()
    var dataTeam: Team = Team()
    var idPlayer: String = ""
    var idTeam: String = ""
    var isFavorite: Bool = false
    var informationData: [String] = []
    var photos: [String] = []
    
    init(idPlayer: String = "", idTeam: String = "", isFavorite: Bool = false) {
        self.idPlayer = idPlayer
        self.idTeam = idTeam
        self.isFavorite = isFavorite
    }
    
    // MARK: - Function
    func loadAPI(completion: @escaping CompletionAPI) {
        var dataPlayer: Player = Player()
        let urlString = "https://www.thesportsdb.com/api/v1/json/1/lookupplayer.php?id=\(idPlayer)"
        Networking.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                if let data = data {
                    let json = data.tojson()
                    let items = json["players"] as? JSArray ?? JSArray()
                    for item in items {
                        let dataAPI = Player(json: item)
                        dataPlayer = dataAPI
                    }
                    self.dataAPI = dataPlayer
                    self.informationData.append(contentsOf: [dataPlayer.descriptions, dataPlayer.facebook, dataPlayer.youtube, dataPlayer.twitter, dataPlayer.website])
                    self.photos.append(contentsOf: [dataPlayer.banner, dataPlayer.fanart1, dataPlayer.fanart2, dataPlayer.fanart3, dataPlayer.fanart4])
                    completion(true, "")
                } else {
                    completion(false, "Data format is error.")
                }
            }
        }
    }
    
    func loadAPITeams(completion: @escaping CompletionAPI) {
        var dataTeam: Team = Team()
        let urlString = "https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id=\(idTeam)"
        Networking.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                if let data = data {
                    let json = data.tojson()
                    let items = json["teams"] as? JSArray ?? JSArray()
                    for item in items {
                        let teamAPI = Team(json: item)
                        dataTeam = teamAPI
                    }
                    self.dataTeam = dataTeam
                    completion(true, "")
                } else {
                    completion(false, "Data format is error.")
                }
            }
        }
    }
    
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfRowInInformation() -> Int {
        return informationData.count
    }
    
    func viewModelForCellInformation(at indexPath: IndexPath) -> InformationCollectionCellVM {
        let item = informationData[indexPath.row]
        let viewModel = InformationCollectionCellVM(dataAPI: item, index: indexPath.row)
        return viewModel
    }
    
    func viewModelForHeader() -> PlayerHeaderVM {
        let player = dataAPI
        let team = dataTeam
        let viewModel = PlayerHeaderVM(dataAPI: player, teamAPI: team)
        return viewModel
    }
    
    func numberOfRowInPhotos() -> Int {
        photos.removeAll { (photo) -> Bool in
            photo == ""
        }
        return photos.count
    }
    
    func viewModelForCellPhotos(at indexPath: IndexPath) -> PhotosCollectionCellVM {
        let item = photos[indexPath.row]
        let viewModel = PhotosCollectionCellVM(photo: item)
        return viewModel
    }
    
    func viewModelForHeaderTeam(title: String) -> TeamsHeaderVM {
        let viewModel = TeamsHeaderVM(title: title)
        return viewModel
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
    
    func updateFavorite() {
        guard let realm = RealmManager.shared.realm else { return }
        if realm.objects(Player.self).filter(NSPredicate(format: "id = %@", dataAPI.id)).isEmpty {
            isFavorite = false
        } else {
            isFavorite = true
        }
    }
    
    func updateFavoriteTeam(id: String) -> Bool {
        guard let realm = RealmManager.shared.realm else { return false }
        if realm.objects(Team.self).filter(NSPredicate(format: "id = %@", id)).isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func setUpPhoto() -> Float {
        if photos == [] {
            return 0
        } else {
            return 50
        }
    }
}
