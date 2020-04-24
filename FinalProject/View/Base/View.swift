//
//  View.swift
//  FinalProject
//
//  Created by MBA0176 on 4/25/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

class View: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    private func loadNib() {
        let bundle = Bundle.main
        var xib: String?
        let name = String(describing: type(of: self))

        if bundle.hasNib(name: name) {
            xib = name
        }

        if let xib = xib, let view = bundle.loadNibNamed(xib, owner: self)?.first as? UIView {
            addSubview(view)
            view.anchorToSuperView()
        }
    }
}
