//
//  FavoriteViewController.swift
//  FinalProject
//
//  Created by MBA0176 on 4/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class FavoriteViewController: ViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private var viewModel = FavoriteViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Function
    private func setupView() {
        let nib = UINib(nibName: "LeagueTableCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "LeagueTableCell")
        let nib2 = UINib(nibName: "TeamTableCell", bundle: .main)
        tableView.register(nib2, forCellReuseIdentifier: "TeamTableCell")
        let nib3 = UINib(nibName: "PlayerTableCell", bundle: .main)
        tableView.register(nib3, forCellReuseIdentifier: "PlayerTableCell")
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
        viewModel.setUpObsever(index: 0, type: DetailLeague.self)
        viewModel.setUpObsever(index: 1, type: Team.self)
        viewModel.setUpObsever(index: 3, type: Player.self)
        fetchData()
        tableView.separatorColor = App.Color.backgroundTableView
    }
    
    func fetchData() {
        viewModel.fetchData { (done) in
            if done {
                self.updateUI()
            } else {
                print("Lỗi fetch data từ realm")
            }
        }
    }
    
    func updateUI() {
        let test = viewModel.separatorColorTableView()
        if test {
            tableView.separatorColor = App.Color.backgroundTableView
        } else {
            tableView.separatorColor = .white
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.numberOfRowInSectionLeague()
        } else if section == 1 {
            return viewModel.numberOfRowInSectionTeam()
        } else {
            return viewModel.numberOfRowInSectionPlayer()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueTableCell", for: indexPath) as? LeagueTableCell ?? LeagueTableCell()
            cell.viewModel = viewModel.viewModelForCellLeague(at: indexPath)
            let item = viewModel.dataLeagues[indexPath.row].logo
            Networking.shared().downloadImage(url: item) { (image) in
                if let image = image {
                    cell.configImage(image: image)
                } else {
                    cell.configImage(image: #imageLiteral(resourceName: "img-logo"))
                }
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamTableCell", for: indexPath) as? TeamTableCell ?? TeamTableCell()
            cell.viewModel = viewModel.viewModelForCellTeam(at: indexPath)
            let item = viewModel.dataTeams[indexPath.row].logo
            Networking.shared().downloadImage(url: item) { (image) in
                if let image = image {
                    cell.configLogoImage(image: image)
                } else {
                    cell.configLogoImage(image: #imageLiteral(resourceName: "img-logo"))
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableCell", for: indexPath) as? PlayerTableCell ?? PlayerTableCell()
            cell.viewModel = viewModel.viewModelForCellPlayer(at: indexPath)
            let item = viewModel.dataPlayers[indexPath.row].cutout
            Networking.shared().downloadImage(url: item) { (image) in
                if let image = image {
                    cell.configPlayerImage(image: image)
                } else {
                    cell.configPlayerImage(image: #imageLiteral(resourceName: "img-player"))
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let data = viewModel.setUpHeader()
        if section == 0 {
            return data[0]
        } else if section == 1 {
            return data[1]
        } else {
            return data[2]
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0 {
                RealmManager.shared.deleteObject(with: viewModel.getLeague(in: indexPath))
                updateUI()
            } else if indexPath.section == 1 {
                RealmManager.shared.deleteObject(with: viewModel.getTeam(in: indexPath))
                updateUI()
            } else {
                RealmManager.shared.deleteObject(with: viewModel.getPlayer(in: indexPath))
                updateUI()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = App.Color.backgroundColor
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = UIColor.white
        }
    }
}

// MARK: - FavoriteViewModelDelegate
extension FavoriteViewController: FavoriteViewModelDelegate {
    func viewModel(viewModel: FavoriteViewModel, needperform action: FavoriteViewModel.Action) {
        fetchData()
    }
}
