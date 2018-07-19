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

    let collectionView:UICollectionView

    init() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method not implemented")
    }

    func setupSubviews(){
        backgroundColor = .white

        addSubview(collectionView)
    }

    func setupConstraints(){
        collectionView.edges(to: self)
    }
}
