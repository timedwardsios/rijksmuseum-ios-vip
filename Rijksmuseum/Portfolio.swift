//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

// responsible for business logic. The conduit between model layer and view

import Foundation

struct PortfolioViewModel {
    let imageUrls:[URL]
}

protocol PortfolioInterface: class {
    var viewModel:PortfolioViewModel {get set}
}

protocol PortfolioEventHandler {
    func didLoad()
}

class PortfolioController: PortfolioEventHandler {
    weak var interface:PortfolioInterface?
    
    func didLoad() {
        //
    }
}
