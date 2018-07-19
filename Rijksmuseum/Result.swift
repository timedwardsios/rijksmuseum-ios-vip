//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import Foundation

public enum Result<Type,Error> {
    case success(Type)
    case failure(Error)
    public var value: Type? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
}
