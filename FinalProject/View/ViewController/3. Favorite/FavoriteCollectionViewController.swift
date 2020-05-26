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
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var deleteSelectButton: UIButton!
    @IBOutlet private weak var bottomCollection: NSLayoutConstraint!
    @IBOutlet weak var emptyDataImageView: UIImageView!
    @IBOutlet weak var emptyDataLabel: UILabel!
    
    // MARK: - Properties
    private var viewModel = FavoriteCollectionViewModel()
    
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
        let nib = UINib(nibName: "LeagueCollectionCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "LeagueCollectionCell")
        let headerNib = UINib(nibName: "TeamsHeaderView", bundle: Bundle.main)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TeamsHeaderView")
        collectionView.dataSource = self
        collectionView.delegate = self
        viewModel.delegate = self
        viewModel.setUpObsever()
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longpress))
        collectionView.addGestureRecognizer(longPress)
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
        if viewModel.setUpEmptyDataView() {
            emptyDataImageView.isHidden = false
            emptyDataLabel.isHidden = false
        } else {
            emptyDataImageView.isHidden = true
            emptyDataLabel.isHidden = true
        }
        
        collectionView.reloadData()
        resetDeleteSelectButton()
    }
    
    @objc private func longpress(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: touchPoint) {
                deleteSelectButton.isHidden = viewModel.isSelect
                collectionView.allowsMultipleSelection = !viewModel.isSelect
                if !viewModel.isSelect {
                    bottomCollection.constant = 50
                    collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
                    viewModel.dictionnarySelectedIndexPath[indexPath] = true
                } else {
                    bottomCollection.constant = 0
                    for (key, _) in viewModel.dictionnarySelectedIndexPath {
                        collectionView.deselectItem(at: key, animated: true)
                    }
                    viewModel.resetDataDelete()
                }
                viewModel.isSelect = !viewModel.isSelect
            }
        }
    }
    
    private func resetDeleteSelectButton() {
        deleteSelectButton.isHidden = true
        collectionView.allowsMultipleSelection = false
        viewModel.isSelect = false
        viewModel.resetDataDelete()
        bottomCollection.constant = 0
    }
    
    @IBAction private func deleteSelectButtonTouchUpInside(_ sender: Any) {
        viewModel.getDataDelete()
        viewModel.deleteSelect()
        viewModel.resetDataDelete()
        deleteSelectButton.isHidden = true
        collectionView.allowsMultipleSelection = false
        viewModel.isSelect = false
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCollectionCell", for: indexPath) as? LeagueCollectionCell else { return UICollectionViewCell() }
            cell.viewModel = viewModel.viewModelForCellLeague(at: indexPath)
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCollectionCell", for: indexPath) as? LeagueCollectionCell else { return UICollectionViewCell() }
            cell.viewModel = viewModel.viewModelForCellTeam(at: indexPath)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCollectionCell", for: indexPath) as? LeagueCollectionCell else { return UICollectionViewCell() }
            cell.viewModel = viewModel.viewModelForCellPlayer(at: indexPath)
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
        if viewModel.isSelect == false {
            collectionView.deselectItem(at: indexPath, animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if viewModel.isSelect {
            viewModel.dictionnarySelectedIndexPath[indexPath] = false
            let index = viewModel.deleteIndexPath.firstIndex(of: indexPath)
            if index == nil {
                viewModel.deleteIndexPath.append(indexPath)
                viewModel.testDeleteButton += 1
            }
        }
        if viewModel.testDeleteButton == viewModel.dictionnarySelectedIndexPath.count {
            for (key, _) in viewModel.dictionnarySelectedIndexPath {
                collectionView.deselectItem(at: key, animated: true)
            }
            resetDeleteSelectButton()
        }
    }
}

// MARK: - FavoriteCollectionViewModelDelegate
extension FavoriteCollectionViewController: FavoriteCollectionViewModelDelegate {
    func viewModel(viewModel: FavoriteCollectionViewModel, needperform action: Action) {
        fetchData()
    }
}
