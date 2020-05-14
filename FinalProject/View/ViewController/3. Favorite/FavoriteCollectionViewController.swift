//
//  FavoriteCollectionViewController.swift
//  FinalProject
//
//  Created by PCI0020 on 5/14/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class FavoriteCollectionViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var viewModel = FavoriteCollectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Function
    private func setupView() {
        let nib = UINib(nibName: "LeagueCollectionCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "LeagueCollectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        fetchData()
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
        collectionView.reloadData()
    }
}

extension FavoriteCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.numberOfRowInSectionLeague()
        } else if section == 1 {
            return viewModel.numberOfRowInSectionTeam()
        } else {
            return viewModel.numberOfRowInSectionPlayer()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCollectionCell", for: indexPath) as? LeagueCollectionCell ?? LeagueCollectionCell()
            cell.viewModel = viewModel.viewModelForCellLeague(at: indexPath)
            let badge = viewModel.dataLeagues[indexPath.row].badge
            Networking.shared().downloadImage(url: badge) { (image) in
                if let image = image {
                    cell.configbadgeImage(image: image)
                } else {
                    cell.configbadgeImage(image: #imageLiteral(resourceName: "img-DefaultImage"))
                }
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCollectionCell", for: indexPath) as? LeagueCollectionCell ?? LeagueCollectionCell()
            cell.viewModel = viewModel.viewModelForCellTeam(at: indexPath)
            let badge = viewModel.dataTeams[indexPath.row].badge
            Networking.shared().downloadImage(url: badge) { (image) in
                if let image = image {
                    cell.configbadgeImage(image: image)
                } else {
                    cell.configbadgeImage(image: #imageLiteral(resourceName: "img-DefaultImage"))
                }
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCollectionCell", for: indexPath) as? LeagueCollectionCell ?? LeagueCollectionCell()
            cell.viewModel = viewModel.viewModelForCellPlayer(at: indexPath)
            let badge = viewModel.dataPlayers[indexPath.row].cutout
            Networking.shared().downloadImage(url: badge) { (image) in
                if let image = image {
                    cell.configbadgeImage(image: image)
                } else {
                    cell.configbadgeImage(image: #imageLiteral(resourceName: "img-DefaultImage"))
                }
            }
            return cell
        }
    }
    
}
