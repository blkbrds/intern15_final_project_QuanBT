//
//  DetailTeamViewModel.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/4/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class DetailTeamViewModel {
    // MARK: - Properties
    var dataAPI: Team = Team()
    var idTeam: String = ""
    var isFavorite: Bool = false
    var informationData: [String] = []
    var photos: [String] = []
    
    init(idTeam: String = "", isFavorite: Bool = false) {
        self.idTeam = idTeam
        self.isFavorite = isFavorite
    }
    
    func getDataTeam(completion: @escaping CompletionAPI) {
        var team: Team = Team()
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
                        team = teamAPI
                    }
                    self.dataAPI = team
                    self.informationData.append(contentsOf: [team.descriptions, team.facebook, team.youtube, team.twitter, team.website])
                    self.photos.append(contentsOf: [team.jersey, team.banner, team.fanart1, team.fanart2, team.fanart3, team.fanart4])
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
    
    func viewModelForHeader() -> DetailTeamHeaderVM {
        let item = dataAPI
        let viewModel = DetailTeamHeaderVM(dataAPI: item)
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
    
    func updateFavorite() {
        guard let realm = RealmManager.shared.realm else { return }
        if realm.objects(Team.self).filter(NSPredicate(format: "id = %@", dataAPI.id)).isEmpty {
            isFavorite = false
        } else {
            isFavorite = true
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
