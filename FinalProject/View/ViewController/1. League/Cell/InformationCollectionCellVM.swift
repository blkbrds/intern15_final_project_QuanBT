//
//  InformationCollectionCellVM.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/1/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class InformationCollectionCellVM {
    // MARK: - Properties
    var dataAPI: String = ""
    var index: Int = 0
    
    // MARK: - Init
    init(dataAPI: String = "", index: Int = 0) {
        self.dataAPI = dataAPI
        self.index = index
    }
}
