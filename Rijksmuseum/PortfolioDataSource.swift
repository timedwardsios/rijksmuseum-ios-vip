//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import Foundation

protocol PortfolioDataSource {
    func numberOfItems(_ items:Int)
}

class PortfolioDataController{

    var artObjects:[ArtObject]
    let artService:ArtService

    init(artService:ArtService) {
        self.artObjects = [ArtObject]()
        self.artService = artService
    }

    func updateSource(){
        let artRequest = ArtRequest(page: 0, starredOnly: false)
        artService.getArtResults(withRequest: artRequest) { (result) in
            switch result {
            case .success(let artObjects):
                self.artObjects = artObjects
            case .failure(_):
                fatalError()
            }
        }
    }
}

extension PortfolioViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artObjects.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PortfolioCell.reuseIdentifier(),
                                                            for: indexPath) as? PortfolioCell else {
            fatalError()
        }
        let artObject = artObjects[indexPath.row]
        cell.viewModel = PortfolioCell.ViewModel(imageUrl: artObject.imageUrl)
        return cell
    }
}

extension PortfolioViewController:UICollectionViewDelegate{
    //
}

extension PortfolioViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
