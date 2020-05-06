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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    // MARK: - Function
    func configbadgeImage(image: UIImage?) {
        photoImageView.image = image ?? #imageLiteral(resourceName: "img-DefaultImage")
    }
    
    private func setupView() {
        let screenWidth = UIScreen.main.bounds.size.width
        widthLayout.constant = screenWidth - (20)
        contentViewCell.layer.cornerRadius = 10
        contentViewCell.clipsToBounds = true
    }
}
