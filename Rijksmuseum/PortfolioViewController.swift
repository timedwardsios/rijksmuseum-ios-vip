//
//  PortfolioViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 29/07/2018.
//  Copyright (c) 2018 Tim Edwards. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import TinyConstraints

class PortfolioViewController: UIViewController{
    private let interactor: PortfolioBusinessLogic
    private let router: PortfolioRoutingLogic
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewLayout())
    private var listings = [Portfolio.FetchArt.ViewModel.Listing]()

    init(interactor: PortfolioBusinessLogic,
         router: PortfolioRoutingLogic){
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Rijksmuseum"
        collectionView.register(ImageViewCell.self,
                                forCellWithReuseIdentifier: ImageViewCell.reuseIdentifier())
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.edges(to: view)
        interactor.fetchArt(request: Portfolio.FetchArt.Request())
    }

    override func viewDidLayoutSubviews() {
        let flowLayout = UICollectionViewFlowLayout()
        let gutterSize = CGFloat(8)
        let cellSize = CGFloat(83.75)
        flowLayout.itemSize = CGSize(width: cellSize, height: cellSize)
        flowLayout.minimumLineSpacing = CGFloat(gutterSize)
        flowLayout.minimumInteritemSpacing = CGFloat(gutterSize)
        flowLayout.sectionInset = UIEdgeInsets(top: gutterSize,
                                               left: gutterSize,
                                               bottom: gutterSize,
                                               right: gutterSize)
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
    }
}

extension PortfolioViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listings.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.reuseIdentifier(),
                                                            for: indexPath) as? ImageViewCell else {
                                                                fatalError()
        }
        let imageUrl = listings[indexPath.row].imageUrl
        cell.setImageUrl(imageUrl)
        return cell
    }
}

extension PortfolioViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 0.5
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 1.0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let associatedObject = viewModel.[indexPath.row].associatedObject
//        eventHandler.didSelectAssociatedObject(associatedObject)
    }
}

extension PortfolioViewController: PortfolioDisplayLogic {
    func updateViewModel(viewModel: Portfolio.FetchArt.ViewModel){
        listings = viewModel.listings
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
