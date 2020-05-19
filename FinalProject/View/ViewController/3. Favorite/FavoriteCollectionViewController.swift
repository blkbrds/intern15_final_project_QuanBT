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
        let headerNib = UINib(nibName: "TeamsHeaderView", bundle: Bundle.main)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TeamsHeaderView")
        collectionView.dataSource = self
        collectionView.delegate = self
        viewModel.delegate = self
        viewModel.setUpObsever()
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
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
        collectionView.reloadData()
    }
}

extension FavoriteCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
            let item = viewModel.dataLeagues[indexPath.row].logo
            Networking.shared().downloadImage(url: item) { (image) in
                if let image = image {
                    cell.configLogoImage(image: image)
                } else {
                    cell.configLogoImage(image: #imageLiteral(resourceName: "img-DefaultImage"))
                }
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCollectionCell", for: indexPath) as? LeagueCollectionCell ?? LeagueCollectionCell()
            cell.viewModel = viewModel.viewModelForCellTeam(at: indexPath)
            let item = viewModel.dataTeams[indexPath.row].badge
            Networking.shared().downloadImage(url: item) { (image) in
                if let image = image {
                    cell.configLogoImage(image: image)
                } else {
                    cell.configLogoImage(image: #imageLiteral(resourceName: "img-DefaultImage"))
                }
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCollectionCell", for: indexPath) as? LeagueCollectionCell ?? LeagueCollectionCell()
            cell.viewModel = viewModel.viewModelForCellPlayer(at: indexPath)
            let item = viewModel.dataPlayers[indexPath.row].cutout
            Networking.shared().downloadImage(url: item) { (image) in
                if let image = image {
                    cell.configLogoImage(image: image)
                } else {
                    cell.configLogoImage(image: #imageLiteral(resourceName: "img-DefaultImage"))
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TeamsHeaderView", for: indexPath) as? TeamsHeaderView {
                sectionHeader.viewModel = viewModel.viewModelForHeaderTeam(title: "Leagues")
                return sectionHeader
            }
            return UICollectionReusableView()
        } else if indexPath.section == 1 {
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TeamsHeaderView", for: indexPath) as? TeamsHeaderView {
                sectionHeader.viewModel = viewModel.viewModelForHeaderTeam(title: "Teams")
                return sectionHeader
            }
            return UICollectionReusableView()
        } else {
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TeamsHeaderView", for: indexPath) as? TeamsHeaderView {
                sectionHeader.viewModel = viewModel.viewModelForHeaderTeam(title: "Players")
                return sectionHeader
            }
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = viewModel.setUpHeader()
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: height[0])
        } else if section == 1 {
            return CGSize(width: collectionView.frame.width, height: height[1])
        } else {
            return CGSize(width: collectionView.frame.width, height: height[2])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
    }
}

// MARK: - FavoriteCollectionViewModelDelegate
extension FavoriteCollectionViewController: FavoriteCollectionViewModelDelegate {
    func viewModel(viewModel: FavoriteCollectionViewModel, needperform action: Action) {
        fetchData()
    }
}

