//
//  DetailLeagueViewModel.swift
//  FinalProject
//
//  Created by Sếp Quân on 4/29/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class DetailLeagueViewModel {
    // MARK: - Properties
    var dataAPI: DetailLeague = DetailLeague()
    var idLeague: String = ""
    var isFavorite: Bool = false
    var informationData: [String] = []
    var teams: [Team] = []
    var photos: [String] = []
    
    init(idLeague: String = "", isFavorite: Bool = false) {
        self.idLeague = idLeague
        self.isFavorite = isFavorite
    }
    
    // MARK: - Function
    func loadAPI(completion: @escaping CompletionAPI) {
        var dataDetail: DetailLeague = DetailLeague()
        let urlString = "https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id=\(idLeague)"
        Networking.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                if let data = data {	
                    let json = data.tojson()
                    let items = json["leagues"] as? JSArray ?? JSArray()
                    for item in items {
                        let dataAPI = DetailLeague(json: item)
                        dataDetail = dataAPI
                    }
                    self.dataAPI = dataDetail
                    self.informationData.append(contentsOf: [dataDetail.descriptions, dataDetail.facebook, dataDetail.youtube, dataDetail.twitter, dataDetail.website])
                    self.photos.append(contentsOf: [dataDetail.fanart1, dataDetail.fanart2, dataDetail.fanart3, dataDetail.fanart4])
                    completion(true, "")
                } else {
                    completion(false, "Data format is error.")
                }
            }
        }
    }
    
    func loadAPITeams(completion: @escaping CompletionAPI) {
        var teams: [Team] = []
        let urlString = "https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=\(idLeague)"
        Networking.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                if let data = data {
                    let json = data.tojson()
                    let items = json["teams"] as? JSArray ?? JSArray()
                    for item in items {
                        let teamAPI = Team(json: item)
                        teams.append(teamAPI)
                    }
                    self.teams = teams
                    completion(true, "")
                } else {
                    completion(false, "Data format is error.")
                }
            }
        }
    }
    
    func numberOfSections() -> Int {
        return 3
    }
    
    func numberOfRowInInformation() -> Int {
        return informationData.count
    }
    
    func viewModelForCellInformation(at indexPath: IndexPath) -> InformationCollectionCellVM {
        let item = informationData[indexPath.row]
        let viewModel = InformationCollectionCellVM(dataAPI: item, index: indexPath.row)
        return viewModel
    }
    
    func viewModelForHeader() -> LeagueHeaderCellVM {
        let item = dataAPI
        let viewModel = LeagueHeaderCellVM(dataAPI: item)
        return viewModel
    }
    
    func numberOfRowInTeams() -> Int {
        return teams.count
    }
    
    func viewModelForCellTeams(at indexPath: IndexPath) -> TeamsCollectionCellVM {
        let item = teams[indexPath.row]
        let viewModel = TeamsCollectionCellVM(dataAPI: item)
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
    
    func updateFavorite() {
        guard let realm = RealmManager.shared.realm else { return }
        if realm.objects(DetailLeague.self).filter(NSPredicate(format: "id = %@", dataAPI.id)).isEmpty {
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
