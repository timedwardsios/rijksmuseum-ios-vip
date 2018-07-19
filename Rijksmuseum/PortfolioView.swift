//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import UIKit
import TinyConstraints

class PortfolioView: UIView {

    let collectionView:UICollectionView

    init(collectionView:UICollectionView) {
        self.collectionView = collectionView
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method not implemented")
    }

    func setupSubviews(){
        collectionView.backgroundColor = .white

        addSubview(collectionView)
    }

    func setupConstraints(){
        collectionView.edges(to: self)
    }
}
