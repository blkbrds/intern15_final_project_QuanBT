//
//  TeamsCollectionCellVM.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/1/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class TeamsCollectionCellVM {
    // MARK: - Properties
      var dataAPI: Team = Team()
      
      // MARK: - Init
      init(dataAPI: Team = Team()) {
          self.dataAPI = dataAPI
      }
}
