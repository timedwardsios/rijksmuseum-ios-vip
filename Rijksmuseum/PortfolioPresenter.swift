//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

// Responsible for business logic. The conduit between model layer and view. UIKit independent.

import Foundation

class PortfolioPresenter {
    weak var interface:PortfolioInterface?
    let artService:ArtService

    init(artService:ArtService) {
        self.artService = artService
    }

    private func loadArt(){
        let artRequest = ArtRequest(page: 0, starredOnly: false)
        artService.getArtResults(withRequest: artRequest) {[weak self] (result) in
            guard let sSelf = self else {return}
            switch result {
            case .success(let artObjects):
                let portfolioListings = artObjects.map({
                    return PortfolioViewModel.PortfolioListing(imageUrl: $0.imageUrl,
                                                               associatedObject: $0)
                })
                sSelf.interface?.viewModel = PortfolioViewModel(portfolioListings: portfolioListings)
            case .failure(_):
                fatalError()
            }
        }
    }
}

extension PortfolioPresenter: PortfolioEventHandler {
    func didLoad() {
        loadArt()
    }

    func didSelectAssociatedObject(_ object: Any) {
        // Do something with art object. Completion handler?
    }
}
