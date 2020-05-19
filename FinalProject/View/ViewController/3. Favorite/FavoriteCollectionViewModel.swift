//
//  FavoriteCollectionViewModel.swift
//  FinalProject
//
//  Created by PCI0020 on 5/14/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import RealmSwift

protocol FavoriteCollectionViewModelDelegate: class {
    func viewModel(viewModel: FavoriteCollectionViewModel, needperform action: Action)
}

final class FavoriteCollectionViewModel {
    // MARK: - Properties
    var dataLeagues: [DetailLeague] = []
    var dataTeams: [Team] = []
    var dataPlayers: [Player] = []
    var notificationTokenLeague: NotificationToken?
    var notificationTokenTeam: NotificationToken?
    var notificationTokenPlayer: NotificationToken?
    weak var delegate: FavoriteCollectionViewModelDelegate?
    
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
    
    func viewModelForCellLeague(at indexPath: IndexPath) -> LeagueCollectionCellVM {
        let item = dataLeagues[indexPath.row]
        let viewModel = LeagueCollectionCellVM(dataLeagues: item, index: 0)
        return viewModel
    }
    
    func numberOfRowInSectionTeam() -> Int {
        return dataTeams.count
    }
    
    func viewModelForCellTeam(at indexPath: IndexPath) -> LeagueCollectionCellVM {
        let item = dataTeams[indexPath.row]
        let viewModel = LeagueCollectionCellVM(dataTeams: item, index: 1)
        return viewModel
    }
    
    func numberOfRowInSectionPlayer() -> Int {
        return dataPlayers.count
    }
    
    func viewModelForCellPlayer(at indexPath: IndexPath) -> LeagueCollectionCellVM {
        let item = dataPlayers[indexPath.row]
        let viewModel = LeagueCollectionCellVM(dataPlayers: item, index: 3)
        return viewModel
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
    
    func viewModelForHeaderTeam(title: String) -> TeamsHeaderVM {
        let viewModel = TeamsHeaderVM(title: title)
        return viewModel
    }
    
    func setUpHeader() -> [CGFloat] {
        let dataLeague = dataLeagues
        let dataTeam = dataTeams
        let dataPlayer = dataPlayers
        switch (dataLeague, dataTeam, dataPlayer) {
        case ([], [], []):
            return [0, 0, 0]
        case (_, [], []):
            return [50, 0, 0]
        case ([], _, []):
            return [0, 50, 0]
        case ([], [], _):
            return [0, 0, 50]
        case (_, _, []):
            return [50, 50, 0]
        case (_, [], _):
            return [50, 0, 50]
        case ([], _, _):
            return [0, 50, 50]
        default:
            return [50, 50, 50]
        }
    }
    
    func setUpObsever() {
        do {
            let realm = try Realm()
            notificationTokenLeague = realm.objects(DetailLeague.self).observe({ [weak self] (action) in
                guard let self = self else { return }
                switch action {
                case .update:
                    self.delegate?.viewModel(viewModel: self, needperform: .reloadData)
                default:
                    break
                }
            })
        } catch {}
        do {
            let realm = try Realm()
            notificationTokenTeam = realm.objects(Team.self).observe({ [weak self] (action) in
                guard let self = self else { return }
                switch action {
                case .update:
                    self.delegate?.viewModel(viewModel: self, needperform: .reloadData)
                default:
                    break
                }
            })
        } catch {}
        do {
            let realm = try Realm()
            notificationTokenPlayer = realm.objects(Player.self).observe({ [weak self] (action) in
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
