//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

// Responsible for business logic. The conduit between model layer and view. UIKit independent.

import Foundation

struct PortfolioViewModel {
    struct PortfolioListing {
        let imageUrl:URL
        let associatedObject: Any
    }
    var portfolioListings:[PortfolioListing]
}

protocol PortfolioInterface:class{
    var viewModel:PortfolioViewModel{get set}
}

protocol PortfolioEventHandler{
    func didLoad()
    func didSelectAssociatedObject(_ object:Any)
}
