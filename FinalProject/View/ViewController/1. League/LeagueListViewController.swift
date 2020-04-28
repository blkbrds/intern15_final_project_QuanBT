//
//  LeagueListViewController.swift
//  FinalProject
//
//  Created by MBA0176 on 4/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

enum Sport: String {
    case soccer = "Soccer"
    case motorsport = "Motorsport"
    case fighting = "Fighting"
}

enum Country: String {
    case england = "England"
    case germany = "Germany"
    case italy = "Italy"
    case spain = "Spain"
    case worldwide = "Worldwide"
    case usa = "USA"
    case international = "International"
    case europe = "Europe"
    case japan = "Japan"
}

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
        loadAPI(sport: sport.rawValue, country: country.rawValue)
    }
    
    private func loadAPI(sport: String, country: String) {
        print("Load API")
        viewModel.loadAPI(sport: sport, country: country) {  (done, msg) in
            if done {
                self.tableView.reloadData()
            } else {
                print("API erorr: \(msg)")
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
        switch sport {
        case .soccer:
            switch index {
            case 0:
                country = .england
            case 1:
                country = .germany
            case 2:
                country = .italy
            default:
                country = .spain
            }
        case .motorsport:
            switch index {
            case 0:
                country = .worldwide
            case 1:
                country = .usa
            case 2:
                country = .international
            default:
                country = .england
            }
        default:
            switch index {
            case 0:
                country = .worldwide
            case 1:
                country = .japan
            case 2:
                country = .europe
            default:
                country = .usa
            }
        }
        loadAPI(sport: sport.rawValue, country: country.rawValue)
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
    
    // MARK: - IBAction
    @IBAction private func nationsButtonTouchUpInside(_ sender: UIButton) {
        setupNationsButton(index: sender.tag)
    }
    
    @IBAction func changedSportSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            sport = .soccer
            nationsButton[0].setImage(#imageLiteral(resourceName: "img-England"), for: .normal)
            nationsButton[1].setImage(#imageLiteral(resourceName: "img-Germany"), for: .normal)
            nationsButton[2].setImage(#imageLiteral(resourceName: "img-Italia"), for: .normal)
            nationsButton[3].setImage(#imageLiteral(resourceName: "img-Spain"), for: .normal)
        case 1:
            sport = .motorsport
            nationsButton[0].setImage(#imageLiteral(resourceName: "img-World"), for: .normal)
            nationsButton[1].setImage(#imageLiteral(resourceName: "img-USA"), for: .normal)
            nationsButton[2].setImage(#imageLiteral(resourceName: "img-International"), for: .normal)
            nationsButton[3].setImage(#imageLiteral(resourceName: "img-England"), for: .normal)
        default:
            sport = .fighting
            nationsButton[0].setImage(#imageLiteral(resourceName: "img-World"), for: .normal)
            nationsButton[1].setImage(#imageLiteral(resourceName: "img-Japan"), for: .normal)
            nationsButton[2].setImage(#imageLiteral(resourceName: "img-Europe"), for: .normal)
            nationsButton[3].setImage(#imageLiteral(resourceName: "img-USA"), for: .normal)
        }
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
