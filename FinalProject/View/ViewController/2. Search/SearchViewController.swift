//
//  SearchViewController.swift
//  FinalProject
//
//  Created by MBA0176 on 4/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

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
        tableView.separatorColor = App.Color.backgroundTableView
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    private func loadAPITeam(teamString: String) {
        print("Load API")
        viewModel.getDataTeam(teamString: teamString) { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                this.tableView.separatorColor = .white
                this.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "Error API", message: msg, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    this.viewModel.resetData()
                    this.tableView.reloadData()
                    this.searchBar.searchTextField.text = nil
                    this.tableView.separatorColor = App.Color.backgroundTableView
                }))
                this.present(alert, animated: true)
            }
        }
    }
    
    private func loadAPIPlayer(playerString: String) {
        print("Load API")
        viewModel.getDataPlayer(playerString: playerString) { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                this.tableView.separatorColor = .white
                this.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "Error API", message: msg, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    this.viewModel.resetData()
                    this.tableView.reloadData()
                    this.searchBar.searchTextField.text = nil
                    this.tableView.separatorColor = App.Color.backgroundTableView
                }))
                this.present(alert, animated: true)
            }
        }
    }
    
    private func setupSearchSegmentedControl() {
        searchBar.searchTextField.text = nil
        tableView.separatorColor = App.Color.backgroundTableView
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamTableCell", for: indexPath) as? TeamTableCell ?? TeamTableCell()
            cell.viewModel = viewModel.viewModelForCellInTeam(at: indexPath)
            let team = viewModel.dataTeams[indexPath.row].logo
            Networking.shared().downloadImage(url: team) { (image) in
                if let image = image {
                    cell.configLogoImage(image: image)
                } else {
                    cell.configLogoImage(image: #imageLiteral(resourceName: "img-DefaultImage"))
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableCell", for: indexPath) as? PlayerTableCell ?? PlayerTableCell()
            cell.viewModel = viewModel.viewModelForCellInPlayer(at: indexPath)
            let thumb = viewModel.dataPlayers[indexPath.row].thumb
            Networking.shared().downloadImage(url: thumb) { (image) in
                if let image = image {
                    cell.configPlayerImage(image: image)
                } else {
                    cell.configPlayerImage(image: #imageLiteral(resourceName: "img-player"))
                }
            }
            return cell
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let upperText = searchText.uppercased()
        if status == .team {
            loadAPITeam(teamString: upperText)
        } else {
            loadAPIPlayer(playerString: upperText)
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
            let vm = DetailTeamViewModel(idTeam: data.id)
            detailTeamVC.viewModel = vm
            navigationController?.isNavigationBarHidden = false
            navigationController?.pushViewController(detailTeamVC, animated: true)
        } else {
            let playerVC = PlayerViewController()
            let data = viewModel.dataPlayers[indexPath.row]
            let vm = PlayerViewModel(idPlayer: data.id, idTeam: data.idTeam)
            playerVC.viewModel = vm
            navigationController?.isNavigationBarHidden = false
            navigationController?.pushViewController(playerVC, animated: true)
        }
    }
}
