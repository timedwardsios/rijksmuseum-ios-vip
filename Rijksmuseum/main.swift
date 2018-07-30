//
//  AppDelegate.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import UIKit

let isRunningTests = NSClassFromString("XCTestCase") != nil
let appDelegateClass : AnyClass = isRunningTests ? TestingAppDelegate.self : AppDelegate.self
let argv = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))
UIApplicationMain(CommandLine.argc, argv, nil, NSStringFromClass(appDelegateClass))
