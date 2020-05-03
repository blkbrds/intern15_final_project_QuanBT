//
//  DetailLeagueViewController.swift
//  FinalProject
//
//  Created by Sếp Quân on 4/29/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

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
    
    override func setupUI() {
        super.setupUI()
    }
    
    // MARK: - Function
    private func setupView() {
        let nib1 = UINib(nibName: "InformationCollectionCell", bundle: Bundle.main)
        collectionView.register(nib1, forCellWithReuseIdentifier: "InformationCollectionCell")
        let nib2 = UINib(nibName: "TeamsCollectionCell", bundle: Bundle.main)
        collectionView.register(nib2, forCellWithReuseIdentifier: "TeamsCollectionCell")
        let headerNib1 = UINib(nibName: "LeagueHeaderView", bundle: Bundle.main)
        collectionView.register(headerNib1, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "LeagueHeaderView")
        let headerNib2 = UINib(nibName: "TeamsHeaderView", bundle: Bundle.main)
        collectionView.register(headerNib2, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TeamsHeaderView")
        collectionView.dataSource = self
        collectionView.delegate = self
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
            loadAPI()
        }
    }
    
    private func loadAPI() {
        print("Load API")
        viewModel.loadAPI { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                this.collectionView.reloadData()
            } else {
                this.showAlert(title: "Erorr API", message: msg)
            }
        }
        viewModel.loadAPITeams { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                this.collectionView.reloadData()
            } else {
                this.showAlert(title: "Erorr API", message: msg)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension DetailLeagueViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.numberOfRowInInformation()
        } else {
            return viewModel.numberOfRowInTeams()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InformationCollectionCell", for: indexPath) as? InformationCollectionCell ?? InformationCollectionCell()
            cell.viewModel = viewModel.viewModelForCellInformation(at: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCollectionCell", for: indexPath) as? TeamsCollectionCell ?? TeamsCollectionCell()
            cell.viewModel = viewModel.viewModelForCellTeams(at: indexPath)
            let badge = viewModel.teams[indexPath.row].strTeamBadge
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
                let logo = viewModel.dataAPI.strLogo
                Networking.shared().downloadImage(url: logo) { (image) in
                    if let image = image {
                        sectionHeader.configLogoImage(image: image)
                    } else {
                        sectionHeader.configLogoImage(image: #imageLiteral(resourceName: "img-logo"))
                    }
                }
                let badge = viewModel.dataAPI.strBadge
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
        } else {
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TeamsHeaderView", for: indexPath) as? TeamsHeaderView {
                sectionHeader.titleLabel.text = "Teams"
                return sectionHeader
            }
            return UICollectionReusableView()
        }
    }
}
