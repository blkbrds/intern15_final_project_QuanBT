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
    @IBOutlet weak var contentViewCell: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentViewCell.layer.cornerRadius = 10
        contentViewCell.clipsToBounds = true
    }

    // MARK: - Function
    func configbadgeImage(image: UIImage?) {
        photoImageView.image = image ?? #imageLiteral(resourceName: "img-DefaultImage")
    }
}
