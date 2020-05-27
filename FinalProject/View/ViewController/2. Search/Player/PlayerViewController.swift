//
//  PlayerViewController.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/8/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import SVProgressHUD

final class PlayerViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var viewModel = PlayerViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
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
        let nib1 = UINib(nibName: "InformationCollectionCell", bundle: Bundle.main)
        collectionView.register(nib1, forCellWithReuseIdentifier: "InformationCollectionCell")
        let nib2 = UINib(nibName: "PhotosCollectionCell", bundle: Bundle.main)
        collectionView.register(nib2, forCellWithReuseIdentifier: "PhotosCollectionCell")
        let headerNib1 = UINib(nibName: "PlayerHeaderView", bundle: Bundle.main)
        collectionView.register(headerNib1, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "PlayerHeaderView")
        let headerNib2 = UINib(nibName: "TeamsHeaderView", bundle: Bundle.main)
        collectionView.register(headerNib2, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TeamsHeaderView")
        collectionView.dataSource = self
        collectionView.delegate = self
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        loadAPI()
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
                
            } else {
                this.showAlert(title: "Erorr API", message: msg)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
extension PlayerViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.numberOfRowInInformation()
        } else {
            return viewModel.numberOfRowInPhotos()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InformationCollectionCell", for: indexPath) as? InformationCollectionCell else { return UICollectionViewCell() }
            cell.viewModel = viewModel.viewModelForCellInformation(at: indexPath)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionCell", for: indexPath) as? PhotosCollectionCell else { return UICollectionViewCell() }
            cell.viewModel = viewModel.viewModelForCellPhotos(at: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 425)
        } else {
            return CGSize(width: collectionView.frame.width, height: CGFloat(viewModel.setUpPhoto()))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PlayerHeaderView", for: indexPath) as? PlayerHeaderView {
                sectionHeader.delegate = self
                sectionHeader.viewModel = viewModel.viewModelForHeader()
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
}

// MARK: - PlayerHeaderDelegate
extension PlayerViewController: PlayerHeaderDelegate {
    func getIdTeam(idTeam: String) {
        let detailTeamVC = DetailTeamViewController()
        let isFavoriteTeam = viewModel.updateFavoriteTeam(id: idTeam)
        let vm = DetailTeamViewModel(idTeam: idTeam, isFavorite: isFavoriteTeam)
        detailTeamVC.viewModel = vm
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(detailTeamVC, animated: true)
    }
}
