//
//  PhotosCollectionCell.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/1/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class PhotosCollectionCell: UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var contentViewCell: UIView!
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var widthLayout: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel = PhotosCollectionCellVM() {
        didSet {
            setupView()
        }
    }
    
    // MARK: - Function
    private func setupView() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        widthLayout.constant = screenWidth - (20)
        contentViewCell.layer.cornerRadius = 10
        contentViewCell.clipsToBounds = true
        let dataAPI = viewModel.photo
        photoImageView.image = nil
        photoImageView.sd_setImage(with: URL(string: dataAPI), placeholderImage: nil)
        if photoImageView.image == nil {
            photoImageView.image = #imageLiteral(resourceName: "img-DefaultImage")
        }
    }
}
