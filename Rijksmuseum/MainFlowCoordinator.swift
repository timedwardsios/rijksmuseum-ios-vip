//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import UIKit

class MainFlowCoordinator {
    let screen:UIScreen
    let window:UIWindow
    let navigationController: UINavigationController
    let mainViewController:MainViewController

    init(screen:UIScreen,
         window:UIWindow) {
        self.screen = screen
        self.window = window
        self.mainViewController = MainViewController()
        self.navigationController = UINavigationController(rootViewController: mainViewController)
    }

    func updateWindow(){
        window.rootViewController = navigationController
        window.frame = screen.bounds
        window.makeKeyAndVisible()
    }
}

