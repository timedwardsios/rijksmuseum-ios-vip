//
//  ViewController.swift
//  RetainCycleTest
//
//  Created by Tim Edwards on 28/04/2019.
//  Copyright © 2019 Tim Edwards. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let first = FirstClass()
    }
}

class FirstClass {
    let secondClass = SecondClass()

    init() {
        secondClass.doTheThing(completion: completion)
    }

    func completion(){
        print("COMPLETION")
    }

    deinit {
        print("DEINIT")
    }
}

class SecondClass {
    func doTheThing(completion: @escaping ()->Void) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            completion()
        }
    }
}
