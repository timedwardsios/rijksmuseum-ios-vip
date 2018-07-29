//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import Foundation

protocol ArtStub {
    var remoteId: String{get}
    var title: String{get}
    var artist: String{get}
    var imageUrl: URL{get}
}

protocol ArtDetails: ArtStub {
    var subtitle: String{get}
    var description: String{get}
}
