//
//  AppDelegate.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let mainScreen:UIScreen
    let mainWindow:UIWindow
    let artService:ArtService
    let mainRouter:MainRouter

    override init() {
        // TODO: clean up
        UIWindow.appearance().backgroundColor = UIColor(hex: "343537")
        UINavigationBar.appearance().barTintColor = UIColor(hex: "40474f")
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont(name: "Rijksmuseum-Bold", size: 22) as Any
        ]
        UICollectionView.appearance().backgroundColor = .clear

        mainScreen = UIScreen.main
        mainWindow = UIWindow()
        mainWindow.backgroundColor = UIWindow.appearance().backgroundColor // workaround
        artService = ArtService()
        self.mainRouter = MainRouter(screen: mainScreen,
                                                       window: mainWindow,
                                                       artService: artService)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        mainRouter.setupWindow()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
}

