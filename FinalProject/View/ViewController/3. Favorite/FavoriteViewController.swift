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
    @IBOutlet private weak var deleteSelectButton: UIButton!
    @IBOutlet private weak var bottomCollection: NSLayoutConstraint!
    
    // MARK: - Properties
    private var viewModel = FavoriteViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
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
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longpress))
        tableView.addGestureRecognizer(longPress)
        viewModel.setUpObsever()
        tableView.separatorColor = App.Color.backgroundTableView
        fetchData()
    }
    
    private func fetchData() {
        viewModel.fetchData { (done) in
            if done {
                self.updateUI()
            } else {
                print("Lỗi fetch data từ realm")
            }
        }
    }
    
    private func updateUI() {
        let test = viewModel.separatorColorTableView()
        if test {
            tableView.separatorColor = App.Color.backgroundTableView
        } else {
            tableView.separatorColor = .white
        }
        resetDeleteSelectButton()
        tableView.reloadData()
    }
    
    @objc private func longpress(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                deleteSelectButton.isHidden = viewModel.isSelect
                tableView.allowsMultipleSelection = !viewModel.isSelect
                if !viewModel.isSelect {
                    bottomCollection.constant = 50
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
                    viewModel.dictionnarySelectedIndexPath[indexPath] = true
                } else {
                    bottomCollection.constant = 0
                    for (key, _) in viewModel.dictionnarySelectedIndexPath {
                        tableView.deselectRow(at: key, animated: true)
                    }
                    viewModel.resetDataDelete()
                }
                viewModel.isSelect = !viewModel.isSelect
            }
        }
    }
    
    private func resetDeleteSelectButton() {
        deleteSelectButton.isHidden = true
        tableView.allowsMultipleSelection = false
        viewModel.isSelect = false
        viewModel.resetDataDelete()
        bottomCollection.constant = 0
    }
    
    // MARK: - IBAction
    @IBAction private func deleteSelectButtonTouchUpInside(_ sender: Any) {
        viewModel.getDataDelete()
        viewModel.deleteSelect()
        viewModel.resetDataDelete()
        deleteSelectButton.isHidden = true
        tableView.allowsMultipleSelection = false
        viewModel.isSelect = false
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueTableCell", for: indexPath) as? LeagueTableCell else { return UITableViewCell() }
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TeamTableCell", for: indexPath) as? TeamTableCell else { return UITableViewCell() }
            cell.viewModel = viewModel.viewModelForCellTeam(at: indexPath)
            let item = viewModel.dataTeams[indexPath.row].badge
            Networking.shared().downloadImage(url: item) { (image) in
                if let image = image {
                    cell.configLogoImage(image: image)
                } else {
                    cell.configLogoImage(image: #imageLiteral(resourceName: "img-logo"))
                }
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableCell", for: indexPath) as? PlayerTableCell else { return UITableViewCell() }
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
                    viewModel.dataLeagues.remove(at: indexPath.row)
                    updateUI()
                } else if indexPath.section == 1 {
                    RealmManager.shared.deleteObject(with: viewModel.getTeam(in: indexPath))
                    viewModel.dataTeams.remove(at: indexPath.row)
                    updateUI()
                } else {
                    RealmManager.shared.deleteObject(with: viewModel.getPlayer(in: indexPath))
                    viewModel.dataPlayers.remove(at: indexPath.row)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.isSelect == false {
            if indexPath.section == 0 {
                let detailLeagueVC = DetailLeagueViewController()
                let data = viewModel.dataLeagues[indexPath.row]
                let vm = DetailLeagueViewModel(idLeague: data.id, isFavorite: true)
                detailLeagueVC.viewModel = vm
                navigationController?.isNavigationBarHidden = false
                navigationController?.pushViewController(detailLeagueVC, animated: true)
            } else if indexPath.section == 1 {
                let detailTeamVC = DetailTeamViewController()
                let data = viewModel.dataTeams[indexPath.row]
                let vm = DetailTeamViewModel(idTeam: data.id, isFavorite: true)
                detailTeamVC.viewModel = vm
                navigationController?.isNavigationBarHidden = false
                navigationController?.pushViewController(detailTeamVC, animated: true)
            } else {
                let detailPlayerVC = PlayerViewController()
                let data = viewModel.dataPlayers[indexPath.row]
                let vm = PlayerViewModel(idPlayer: data.id, idTeam: data.idTeam, isFavorite: true)
                detailPlayerVC.viewModel = vm
                navigationController?.isNavigationBarHidden = false
                navigationController?.pushViewController(detailPlayerVC, animated: true)
            }
        } else {
            viewModel.dictionnarySelectedIndexPath[indexPath] = true
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if viewModel.isSelect {
            viewModel.dictionnarySelectedIndexPath[indexPath] = false
            viewModel.testDeleteButton += 1
        }
        if viewModel.testDeleteButton == viewModel.dictionnarySelectedIndexPath.count {
            resetDeleteSelectButton()
        }
    }
}

// MARK: - FavoriteViewModelDelegate
extension FavoriteViewController: FavoriteViewModelDelegate {
    func viewModel(viewModel: FavoriteViewModel, needperform action: Action) {
        fetchData()
    }
}
