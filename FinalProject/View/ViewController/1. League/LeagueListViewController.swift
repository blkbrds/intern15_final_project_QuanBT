//
//  LeagueListViewController.swift
//  FinalProject
//
//  Created by MBA0176 on 4/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class LeagueListViewController: ViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var sportSegmentedControl: UISegmentedControl!
    @IBOutlet private var nationsButton: [UIButton]!
    
    // MARK: - Properties
    private var viewModel = LeagueListViewModel()
    private var sport: Sport = .soccer
    private var country: Country = .england
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for item in nationsButton {
            item.layer.cornerRadius = item.bounds.width / 2
            item.clipsToBounds = true
        }
    }
    
    override func setupUI() {
        super.setupUI()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        sportSegmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        nationsButton[0].borderWidth = 4
        nationsButton[0].borderColor = App.Color.tabBarTintColor
    }
    
    // MARK: - Function
    private func setupView() {
        let nib = UINib(nibName: "LeagueTableCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "LeagueTableCell")
        tableView.dataSource = self
        tableView.delegate = self
        loadAPI(sport: sport.rawValue, country: country.rawValue)
    }
    
    private func loadAPI(sport: String, country: String) {
        print("Load API")
        viewModel.loadAPI(sport: sport, country: country) { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                this.tableView.reloadData()
            } else {
                this.showAlert(title: "Erorr API", message: msg)
            }
        }
        tableView.alpha = 0
        UIView.animate(withDuration: 2) {
            self.tableView.alpha = 1
        }
        tableView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    private func setupNationsButton(index: Int) {
        nationsButton.forEach { item in
            item.borderWidth = 0
        }
        nationsButton[index].borderWidth = 4
        nationsButton[index].borderColor = App.Color.tabBarTintColor
    }
    
    private func resetNationsButton() {
        nationsButton.forEach { item in
            item.borderWidth = 0
        }
        nationsButton[0].borderWidth = 4
        nationsButton[0].borderColor = App.Color.tabBarTintColor
        switch sport {
        case .soccer:
            country = .england
        case .motorsport:
            country = .worldwide
        default:
            country = .worldwide
        }
    }
    
    private func setupUINationsButton(sport: Sport) {
        for (index, item) in nationsButton.enumerated() {
            item.setImage(sport.country[index].flag, for: .normal)
        }
    }
    
    // MARK: - IBAction
    @IBAction private func nationsButtonTouchUpInside(_ sender: UIButton) {
        setupNationsButton(index: sender.tag)
        loadAPI(sport: sport.rawValue, country: sport.country[sender.tag].rawValue)
    }
    
    @IBAction func changedSportSegmentedControl(_ sender: UISegmentedControl) {
            switch sender.selectedSegmentIndex {
            case 0:
                sport = .soccer
            case 1:
                sport = .motorsport
            default:
                sport = .fighting
            }
        setupUINationsButton(sport: sport)
        resetNationsButton()
        loadAPI(sport: sport.rawValue, country: country.rawValue)
    }
}

// MARK: - UITableViewDataSource
extension LeagueListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueTableCell", for: indexPath) as? LeagueTableCell ?? LeagueTableCell()
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        let item = viewModel.dataAPIs[indexPath.row].strLogo
        Networking.shared().downloadImage(url: item) { (image) in
            if let image = image {
                cell.configImage(image: image)
            } else {
                cell.configImage(image: #imageLiteral(resourceName: "img-logo"))
            }
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LeagueListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailLeagueVC = DetailLeagueViewController()
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(detailLeagueVC, animated: true)
    }
}
