//
//  Popup.swift
//  FinalProject
//
//  Created by MBA0176 on 4/25/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

class Popup: UIViewController {

    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
        modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    }
}
