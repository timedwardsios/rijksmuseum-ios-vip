//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import UIKit

class MainFlowController {
    let screen:UIScreen
    let window:UIWindow
    let navigationController: UINavigationController
    let portfolioViewController:PortfolioViewController

    init(screen:UIScreen,
         window:UIWindow,
         artService:ArtService) {
        self.screen = screen
        self.window = window
        self.portfolioViewController = PortfolioViewController(artService: artService)
        self.navigationController = UINavigationController(rootViewController: portfolioViewController)
    }

    func updateWindow(){
        window.rootViewController = navigationController
        window.frame = screen.bounds
        window.makeKeyAndVisible()
    }
}

