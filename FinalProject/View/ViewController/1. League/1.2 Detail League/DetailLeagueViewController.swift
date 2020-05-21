//
//  DetailLeagueViewController.swift
//  FinalProject
//
//  Created by Sếp Quân on 4/29/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import SVProgressHUD

final class DetailLeagueViewController: ViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var viewModel = DetailLeagueViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        if viewModel.dataAPI.id != "" {
            viewModel.updateFavorite()
        }
        if viewModel.isFavorite {
            let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(unFavoriteButtonTouchUpInside))
            navigationItem.rightBarButtonItem = favoriteButton
        } else {
            let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonTouchUpInside))
            navigationItem.rightBarButtonItem = favoriteButton
        }
    }
    
    // MARK: - Function
    private func setupView() {
        let nib1 = UINib(nibName: "InformationCollectionCell",	bundle: Bundle.main)
        collectionView.register(nib1, forCellWithReuseIdentifier: "InformationCollectionCell")
        let nib2 = UINib(nibName: "TeamsCollectionCell", bundle: Bundle.main)
        collectionView.register(nib2, forCellWithReuseIdentifier: "TeamsCollectionCell")
        let nib3 = UINib(nibName: "PhotosCollectionCell", bundle: Bundle.main)
        collectionView.register(nib3, forCellWithReuseIdentifier: "PhotosCollectionCell")
        let headerNib1 = UINib(nibName: "LeagueHeaderView", bundle: Bundle.main)
        collectionView.register(headerNib1, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "LeagueHeaderView")
        let headerNib2 = UINib(nibName: "TeamsHeaderView", bundle: Bundle.main)
        collectionView.register(headerNib2, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TeamsHeaderView")
        let headerNib3 = UINib(nibName: "TeamsHeaderView", bundle: Bundle.main)
        collectionView.register(headerNib3, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TeamsHeaderView")
        collectionView.dataSource = self
        collectionView.delegate = self
        loadAPI()
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2743943632, green: 0.7092565894, blue: 0.5255461931, alpha: 1)
        
    }
    
    @objc private func favoriteButtonTouchUpInside() {
        viewModel.addFavorite()
        viewModel.isFavorite = true
        if viewModel.isFavorite {
            let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(unFavoriteButtonTouchUpInside))
            navigationItem.rightBarButtonItem = favoriteButton
        } else {
            let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonTouchUpInside))
            navigationItem.rightBarButtonItem = favoriteButton
        }
    }
    
    @objc private func unFavoriteButtonTouchUpInside() {
        viewModel.deleteFavorite()
        viewModel.isFavorite = false
        if viewModel.isFavorite {
            let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(unFavoriteButtonTouchUpInside))
            navigationItem.rightBarButtonItem = favoriteButton
        } else {
            let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonTouchUpInside))
            navigationItem.rightBarButtonItem = favoriteButton
        }
    }
    
    private func loadAPI() {
        SVProgressHUD.show()
        viewModel.loadAPI { [weak self] (done, msg) in
            SVProgressHUD.dismiss()
            guard let this = self else { return }
            if done {
                this.collectionView.reloadData()
                
            } else {
                this.showAlert(title: "Erorr API", message: msg)
            }
        }
        SVProgressHUD.show()
        viewModel.loadAPITeams { [weak self] (done, msg) in
            SVProgressHUD.dismiss()
            guard let this = self else { return }
            if done {
                this.collectionView.reloadData()
            } else {
                this.showAlert(title: "Erorr API", message: msg)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
extension DetailLeagueViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.numberOfRowInInformation()
        } else if section == 1 {
            return viewModel.numberOfRowInTeams()
        } else {
            return viewModel.numberOfRowInPhotos()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InformationCollectionCell", for: indexPath) as? InformationCollectionCell ?? InformationCollectionCell()
            cell.viewModel = viewModel.viewModelForCellInformation(at: indexPath)
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCollectionCell", for: indexPath) as? TeamsCollectionCell ?? TeamsCollectionCell()
            cell.viewModel = viewModel.viewModelForCellTeams(at: indexPath)
            cell.delegate = self
            let badge = viewModel.teams[indexPath.row].badge
            Networking.shared().downloadImage(url: badge) { (image) in
                if let image = image {
                    cell.configbadgeImage(image: image)
                } else {
                    cell.configbadgeImage(image: #imageLiteral(resourceName: "img-DefaultImage"))
                }
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionCell", for: indexPath) as? PhotosCollectionCell ?? PhotosCollectionCell()
            let photo = viewModel.photos[indexPath.row]
            Networking.shared().downloadImage(url: photo) { (image) in
                if let image = image {
                    cell.configbadgeImage(image: image)
                } else {
                    cell.configbadgeImage(image: #imageLiteral(resourceName: "img-DefaultImage"))
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 325)
        } else {
            return CGSize(width: collectionView.frame.width, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LeagueHeaderView", for: indexPath) as? LeagueHeaderView {
                sectionHeader.viewModel = viewModel.viewModelForHeader()
                let logo = viewModel.dataAPI.logo
                Networking.shared().downloadImage(url: logo) { (image) in
                    if let image = image {
                        sectionHeader.configLogoImage(image: image)
                    } else {
                        sectionHeader.configLogoImage(image: #imageLiteral(resourceName: "img-logo"))
                    }
                }
                let badge = viewModel.dataAPI.badge
                Networking.shared().downloadImage(url: badge) { (image) in
                    if let image = image {
                        sectionHeader.configbadgeImage(image: image)
                    } else {
                        sectionHeader.configbadgeImage(image: #imageLiteral(resourceName: "img-DefaultImage"))
                    }
                }
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
                sectionHeader.viewModel = viewModel.viewModelForHeaderTeam(title: "Photos")
                return sectionHeader
            }
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let detailTeamVC = DetailTeamViewController()
            let data = viewModel.teams[indexPath.row]
            let vm = DetailTeamViewModel(idTeam: data.id, isFavorite: data.isFavorite)
            detailTeamVC.viewModel = vm
            navigationController?.isNavigationBarHidden = false
            navigationController?.pushViewController(detailTeamVC, animated: true)
        }
    }
}

// MARK: - TeamsCollectionCellDelegate
extension DetailLeagueViewController: TeamsCollectionCellDelegate {
    func addTeamsCollectionCell(cell: TeamsCollectionCell, didFavoriteButton data: Team) {
        RealmManager.shared.addObject(with: data)
    }
    
    func deleteTeamsCollectionCell(cell: TeamsCollectionCell, didFavoriteButton data: [Team]) {
        RealmManager.shared.deleteAllObject(with: data)
    }
}
