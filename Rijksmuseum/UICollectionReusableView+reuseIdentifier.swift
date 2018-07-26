//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import UIKit

extension UICollectionReusableView {
    class func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
