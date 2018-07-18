//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import UIKit
import TinyConstraints

class MainView: UIView {

    let label = UILabel()

    init() {
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method not implemented")
    }

    func setupSubviews(){
        backgroundColor = .white

        label.text = "Rijkmuseum"
        self.addSubview(label)
    }

    func setupConstraints(){
        label.edges(to: self)
    }
}
