//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import UIKit
import TinyConstraints
import SDWebImage

class PortfolioViewCell: UICollectionViewCell {
    struct ViewModel {
        let imageUrl:URL?
    }

    private let imageView = UIImageView()
    var viewModel:ViewModel {
        didSet{
            imageView.sd_cancelCurrentImageLoad()
            imageView.sd_setImage(with: viewModel.imageUrl, completed: nil)
        }
    }

    override init(frame: CGRect) {
        self.viewModel = ViewModel(imageUrl: nil)
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method not implemented")
    }

    func setupSubviews(){
        addSubview(imageView)
    }

    func setupConstraints(){
        imageView.edges(to: self)
    }
}
