//
//  SearchViewModel.swift
//  FinalProject
//
//  Created by MBA0176 on 4/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class SearchViewModel {
    // MARK: - Properties
    var dataTeams: [Team] = []
    var dataPlayers: [Player] = []
    
    // MARK: - Function
    func getDataTeam(teamString: String, completion: @escaping CompletionAPI) {
        let aString = teamString
        let newString = aString.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        var team: [Team] = []
        let urlString = "https://www.thesportsdb.com/api/v1/json/1/searchteams.php?t=\(newString)"
        Networking.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                if let data = data {
                    let json = data.tojson()
                    let items = json["teams"] as? JSArray ?? JSArray()
                    for item in items {
                        let teamAPI = Team(json: item)
                        team.append(teamAPI)
                    }
                    self.dataTeams = team
                    completion(true, "")
                } else {
                    completion(false, "Data format is error.")
                }
            }
        }
    }
    
    func getDataPlayer(playerString: String, completion: @escaping CompletionAPI) {
        let aString = playerString
        let newString = aString.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        var players: [Player] = []
        let urlString = "https://www.thesportsdb.com/api/v1/json/1/searchplayers.php?p=\(newString)"
        Networking.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                if let data = data {
                    let json = data.tojson()
                    let items = json["player"] as? JSArray ?? JSArray()
                    for item in items {
                        let playerAPI = Player(json: item)
                        players.append(playerAPI)
                    }
                    self.dataPlayers = players
                    completion(true, "")
                } else {
                    completion(false, "Data format is error.")
                }
            }
        }
    }
    
    func resetData() {
        dataPlayers = []
        dataTeams = []
    }
    
    func numberOfRowInTeam() -> Int {
        return dataTeams.count
    }
    
    func viewModelForCellInTeam(at indexPath: IndexPath) -> TeamTableCellVM {
        let item = dataTeams[indexPath.row]
        let viewModel = TeamTableCellVM(dataAPI: item)
        return viewModel
    }
    
    func numberOfRowInPlayer() -> Int {
        return dataPlayers.count
    }
    
    func viewModelForCellInPlayer(at indexPath: IndexPath) -> PlayerTableCellVM {
        let item = dataPlayers[indexPath.row]
        let viewModel = PlayerTableCellVM(dataAPI: item)
        return viewModel
    }
}
