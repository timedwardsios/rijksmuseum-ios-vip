//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import Foundation

protocol ArtDetails: ArtPrimitive {
    var subtitle: String{get}
    var description: String{get}
}
