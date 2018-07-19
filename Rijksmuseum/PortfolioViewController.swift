//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController {

    let artService:ArtService
    let portfolioView:PortfolioView
    var artObjects = [ArtObject]()

    init(artService:ArtService) {
        self.artService = artService
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(PortfolioCell.self, forCellWithReuseIdentifier: PortfolioCell.reuseIdentifier())
        self.portfolioView = PortfolioView(collectionView: collectionView)
        super.init(nibName: nil, bundle: nil)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method not implemented")
    }

    override func loadView() {
        view = portfolioView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rijksmuseum"
        let artRequest = ArtRequest(page: 0, starredOnly: false)
        artService.getArtResults(withRequest: artRequest) { (result) in
            switch result {
            case .success(let artObjects):
                self.artObjects = artObjects
                DispatchQueue.main.async {
                    self.portfolioView.collectionView.reloadData()
                }
            case .failure(_):
                fatalError()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        //
    }

    override func viewDidDisappear(_ animated: Bool) {
        //
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
