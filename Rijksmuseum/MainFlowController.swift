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
    let portfolioView:PortfolioView

    init(screen:UIScreen,
         window:UIWindow,
         artService:ArtService) {
        self.screen = screen
        self.window = window
        let portfolioController = PortfolioController()
        self.portfolioView = PortfolioView(eventHandler: portfolioController)
        self.navigationController = UINavigationController(rootViewController: portfolioView)
    }

    func updateWindow(){
        window.rootViewController = navigationController
        window.frame = screen.bounds
        window.makeKeyAndVisible()
    }
}

