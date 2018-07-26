//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import UIKit

class MainRouter {
    let screen:UIScreen
    let window:UIWindow
    let navigationController: UINavigationController

    init(screen:UIScreen,
         window:UIWindow,
         artService:ArtService) {
        self.screen = screen
        self.window = window
        let portfolioPresenter = PortfolioPresenter(artService: artService)
        let portfolioViewController = PortfolioViewController(eventHandler: portfolioPresenter)
        portfolioPresenter.interface = portfolioViewController
        self.navigationController = UINavigationController(rootViewController: portfolioViewController)
    }

    func setupWindow(){
        window.rootViewController = navigationController
        window.frame = screen.bounds
        window.makeKeyAndVisible()
    }
}

