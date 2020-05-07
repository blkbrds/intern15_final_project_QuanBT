//
//  PlayerTableCellVM.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/6/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class PlayerTableCellVM {
    // MARK: - Properties
      var dataAPI: Player = Player()
      
      // MARK: - Init
      init(dataAPI: Player = Player()) {
          self.dataAPI = dataAPI
      }
}
