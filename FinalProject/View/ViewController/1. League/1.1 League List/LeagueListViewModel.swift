//
//  LeagueListViewModel.swift
//  FinalProject
//
//  Created by MBA0176 on 4/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import UIKit

final class LeagueListViewModel {
    // MARK: - Properties
    var dataAPIs: [League] = []
    
    // MARK: - Function
    func loadAPI(sport: String = "Soccer", country: String = "England", completion: @escaping CompletionAPI) {
        var dataPage: [League] = []
        let urlString = "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?c=\(country)&s=\(sport)"
        Networking.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                if let data = data {
                    let json = data.tojson()
                    let items = json["countrys"] as? JSArray ?? JSArray()
                    for item in items {
                        let dataAPI = League(json: item)
                        dataPage.append(dataAPI)
                    }
                    self.dataAPIs = dataPage
                    completion(true, "")
                } else {
                    completion(false, "Data format is error.")
                }
            }
        }
    }
    
    func numberOfRowInSection() -> Int {
        return dataAPIs.count
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> LeagueTableCellVM {
        let item = dataAPIs[indexPath.row]
        let viewModel = LeagueTableCellVM(dataAPI: item)
        return viewModel
    }
    
    func downloadImage() {
        for item in dataAPIs {
            Networking.shared().downloadImage(url: item.logo) { (image) in
                if let image = image {
                    item.logoImage = image
                } else {
                    item.logoImage = #imageLiteral(resourceName: "img-logo")
                }
            }
        }
    }
}

