//
//  FavoriteViewModel.swift
//  FinalProject
//
//  Created by MBA0176 on 4/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import RealmSwift

protocol FavoriteViewModelDelegate: class {
    func viewModel(viewModel: FavoriteViewModel, needperform action: FavoriteViewModel.Action)
}

final class FavoriteViewModel {
    // MARK: - enum
    enum Action {
        case reloadData
    }
    
    // MARK: - Properties
    var dataLeagues: [DetailLeague] = []
    var dataTeams: [Team] = []
    var dataPlayers: [Player] = []
    var notificationTokenLeague: NotificationToken?
    var notificationTokenTeam: NotificationToken?
    var notificationTokenPlayer: NotificationToken?
    weak var delegate: FavoriteViewModelDelegate?
    
    // MARK: - Function
    func fetchData(completion: (Bool) -> Void) {
        do {
            // realm
            let realm = try Realm()
            
            // results
            let leagues = realm.objects(DetailLeague.self)
            let teams = realm.objects(Team.self)
            let players = realm.objects(Player.self)
            
            // convert to array
            dataLeagues = Array(leagues)
            dataTeams = Array(teams)
            dataPlayers = Array(players)
            
            // call back
            completion(true)
            
        } catch {
            // call back
            completion(false)
        }
    }
    
    func numberOfRowInSectionLeague() -> Int {
        return dataLeagues.count
    }
    
    func viewModelForCellLeague(at indexPath: IndexPath) -> LeagueTableCellVM {
        let item = dataLeagues[indexPath.row]
        let viewModel = LeagueTableCellVM(dataFavorite: item, favorite: true)
        return viewModel
    }
    
    func numberOfRowInSectionTeam() -> Int {
        return dataTeams.count
    }
    
    func viewModelForCellTeam(at indexPath: IndexPath) -> TeamTableCellVM {
        let item = dataTeams[indexPath.row]
        let viewModel = TeamTableCellVM(dataAPI: item, favorite: true)
        return viewModel
    }
    
    func numberOfRowInSectionPlayer() -> Int {
        return dataPlayers.count
    }
    
    func viewModelForCellPlayer(at indexPath: IndexPath) -> PlayerTableCellVM {
        let item = dataPlayers[indexPath.row]
        let viewModel = PlayerTableCellVM(dataAPI: item, favorite: true )
        return viewModel
    }
    
    func setUpObsever<T: Object>(index: Int, type: T.Type) {
        if index == 0 {
            do {
                let realm = try Realm()
                notificationTokenLeague = realm.objects(T.self).observe({ [weak self] (action) in
                    guard let self = self else { return }
                    switch action {
                    case .update:
                        self.delegate?.viewModel(viewModel: self, needperform: .reloadData)
                    default:
                        break
                    }
                })
            } catch {}
        } else if index == 1 {
            do {
                let realm = try Realm()
                notificationTokenTeam = realm.objects(T.self).observe({ [weak self] (action) in
                    guard let self = self else { return }
                    switch action {
                    case .update:
                        self.delegate?.viewModel(viewModel: self, needperform: .reloadData)
                    default:
                        break
                    }
                })
            } catch {}
        } else {
            do {
                let realm = try Realm()
                notificationTokenPlayer = realm.objects(T.self).observe({ [weak self] (action) in
                    guard let self = self else { return }
                    switch action {
                    case .update:
                        self.delegate?.viewModel(viewModel: self, needperform: .reloadData)
                    default:
                        break
                    }
                })
            } catch {}
        }
    }
    
    func getLeague(in index: IndexPath) -> DetailLeague {
        return dataLeagues[index.row]
    }
    
    func getTeam(in index: IndexPath) -> Team {
        return dataTeams[index.row]
    }
    
    func getPlayer(in index: IndexPath) -> Player {
        return dataPlayers[index.row]
    }
    
    func setUpHeader() -> ([String]) {
        let dataLeague = dataLeagues
        let dataTeam = dataTeams
        let dataPlayer = dataPlayers
        switch (dataLeague, dataTeam, dataPlayer) {
        case ([], [], []):
            return ["", "", ""]
        case (_, [], []):
            return ["Leagues", "", ""]
        case ([], _, []):
            return ["", "Teams", ""]
        case ([], [], _):
            return ["", "", "Players"]
        case (_, _, []):
            return ["Leagues", "Teams", ""]
        case (_, [], _):
            return ["Leagues", "", "Players"]
        case ([], _, _):
            return ["", "Teams", "Players"]
        default:
            return ["Leagues", "Teams", "Players"]
        }
    }
    
    func separatorColorTableView() -> Bool {
        if dataLeagues == [] && dataTeams == [] && dataPlayers == [] {
            return true
        } else {
            return false
        }
    }
}
