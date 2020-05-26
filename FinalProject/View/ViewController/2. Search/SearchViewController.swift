//
//  SearchViewController.swift
//  FinalProject
//
//  Created by MBA0176 on 4/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import SVProgressHUD

final class SearchViewController: ViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private var viewModel = SearchViewModel()
    private var status: Search = .team
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        tableView.reloadData()
    }
    
    override func setupUI() {
        super.setupUI()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        searchSegmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        searchBar.backgroundColor = App.Color.backgroundColor
    }
    
    // MARK: - Function
    private func setupView() {
        let nib = UINib(nibName: "TeamTableCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "TeamTableCell")
        let nib2 = UINib(nibName: "PlayerTableCell", bundle: .main)
        tableView.register(nib2, forCellReuseIdentifier: "PlayerTableCell")
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    private func loadAPITeam(teamString: String) {
        SVProgressHUD.show()
        viewModel.getDataTeam(teamString: teamString) { [weak self] (done, msg) in
            SVProgressHUD.dismiss()
            guard let this = self else { return }
            if done {
                this.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "Error API", message: msg, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    this.viewModel.resetData()
                    this.tableView.reloadData()
                    this.searchBar.searchTextField.text = nil
                }))
                this.present(alert, animated: true)
            }
        }
    }
    
    private func loadAPIPlayer(playerString: String) {
        SVProgressHUD.show()
        viewModel.getDataPlayer(playerString: playerString) { [weak self] (done, msg) in
            SVProgressHUD.dismiss()
            guard let this = self else { return }
            if done {
                this.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "Error API", message: msg, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    this.viewModel.resetData()
                    this.tableView.reloadData()
                    this.searchBar.searchTextField.text = nil
                }))
                this.present(alert, animated: true)
            }
        }
    }
    
    private func setupSearchSegmentedControl() {
        searchBar.searchTextField.text = nil
        viewModel.resetData()
        tableView.reloadData()
    }
    
    // MARK: - IBAction
    @IBAction private func changedSearchSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            status = .team
            setupSearchSegmentedControl()
        default:
            status = .player
            setupSearchSegmentedControl()
        }
    }
    
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if status == .team {
            return viewModel.numberOfRowInTeam()
        } else {
            return viewModel.numberOfRowInPlayer()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if status == .team {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TeamTableCell", for: indexPath) as? TeamTableCell else { return UITableViewCell() }
            cell.viewModel = viewModel.viewModelForCellInTeam(at: indexPath)
            cell.delegate = self
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableCell", for: indexPath) as? PlayerTableCell else { return UITableViewCell() }
            cell.viewModel = viewModel.viewModelForCellInPlayer(at: indexPath)
            cell.delegate = self
            return cell
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            searchBar.endEditing(true)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let searchText = searchBar.searchTextField.text {
            if searchText == "" {
                self.viewModel.resetData()
                self.tableView.reloadData()
            } else {
                if self.status == .team {
                    self.loadAPITeam(teamString: searchText)
                } else {
                    self.loadAPIPlayer(playerString: searchText)
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            searchBar.becomeFirstResponder()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.text = nil
        viewModel.resetData()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if status == .team {
            let detailTeamVC = DetailTeamViewController()
            let data = viewModel.dataTeams[indexPath.row]
            let vm = DetailTeamViewModel(idTeam: data.id, isFavorite: data.isFavorite)
            detailTeamVC.viewModel = vm
            navigationController?.pushViewController(detailTeamVC, animated: true)
        } else {
            let playerVC = PlayerViewController()
            let data = viewModel.dataPlayers[indexPath.row]
            let vm = PlayerViewModel(idPlayer: data.id, idTeam: data.idTeam, isFavorite: data.isFavorite)
            playerVC.viewModel = vm
            navigationController?.pushViewController(playerVC, animated: true)
        }
    }
}

// MARK: - TeamTableCellDelegate
extension SearchViewController: TeamTableCellDelegate {
    func addTeamTableCell(cell: TeamTableCell, didFavoriteButton data: Team) {
        RealmManager.shared.addObject(with: data)
    }
    
    func deleteTeamTableCell(cell: TeamTableCell, didFavoriteButton data: [Team]) {
        RealmManager.shared.deleteAllObject(with: data)
    }
}

// MARK: - PlayerTableCellDelegate
extension SearchViewController: PlayerTableCellDelegate {
    func addPlayerTableCell(cell: PlayerTableCell, didFavoriteButton data: Player) {
        RealmManager.shared.addObject(with: data)
    }
    
    func deletePlayerTableCell(cell: PlayerTableCell, didFavoriteButton data: [Player]) {
        RealmManager.shared.deleteAllObject(with: data)
    }
}
