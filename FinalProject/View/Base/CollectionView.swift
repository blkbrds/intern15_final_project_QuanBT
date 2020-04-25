//
//  CollectionView.swift
//  FinalProject
//
//  Created by MBA0176 on 4/25/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

class CollectionView: UICollectionView { }

extension UICollectionViewCell {
    var collectionView: UICollectionView? {
        return superview as? UICollectionView
    }

    var indexPath: IndexPath? {
        return collectionView?.indexPath(for: self)
    }


}
