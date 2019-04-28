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
        secondClass.doTheThing { (result) in
            switch result {
            case .success(let s):
                print("RESULT: " + String(s))
            case .failure(let e):
                print(e.localizedDescription)
            }
        }
    }

    deinit {
        print("DEINIT")
    }
}

class SecondClass {

    var results = [Result<String, Error>]()

    init() {
        for _ in 1...100 {
            struct Err: Error {}
            results.append(.failure(Err()))
        }
    }


    func doTheThing(completion: @escaping (Result<Int, Error>)->Void) {
        for result in results {
            let _ = result.unwrap(errorHandler: completion)
        }
    }
}

public extension Result {
    func unwrap<T>(errorHandler: ((Result<T, Error>)->Void)) -> Success? {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            errorHandler(.failure(error))
        }
        return nil
    }
}
