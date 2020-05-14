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
    var informationData: [String] = []
    var photos: [String] = []
    
    init(idPlayer: String = "", idTeam: String = "") {
        self.idPlayer = idPlayer
        self.idTeam = idTeam
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
        return photos.count
    }
    
    func viewModelForHeaderTeam(title: String) -> TeamsHeaderVM {
        let viewModel = TeamsHeaderVM(title: title)
        return viewModel
    }
}
