//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

// Responsible for UI, animation, delegating UI callbacks.

import UIKit
import TinyConstraints

//class PortfolioViewController: UIViewController, PortfolioInterface{
//    let collectionView = UICollectionView(frame: .zero,
//                                          collectionViewLayout: UICollectionViewLayout())
//
//    var viewModel = PortfolioViewModel(portfolioListings: [PortfolioViewModel.PortfolioListing]()) {
//        didSet{
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
//    }
//
//    let eventHandler:PortfolioEventHandler
//    init(eventHandler: PortfolioEventHandler) {
//        self.eventHandler = eventHandler
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("Method not implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        eventHandler.didLoad()
//
//        title = "Rijksmuseum"
//
//        collectionView.register(ImageViewCell.self,
//                                forCellWithReuseIdentifier: ImageViewCell.reuseIdentifier())
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        view.addSubview(collectionView)
//        collectionView.edges(to: view)
//    }
//
//    override func viewDidLayoutSubviews() {
//        let flowLayout = UICollectionViewFlowLayout()
//        let gutterSize = CGFloat(8)
//        let cellSize = CGFloat(83.75)
//        flowLayout.itemSize = CGSize(width: cellSize, height: cellSize)
//        flowLayout.minimumLineSpacing = CGFloat(gutterSize)
//        flowLayout.minimumInteritemSpacing = CGFloat(gutterSize)
//        flowLayout.sectionInset = UIEdgeInsets(top: gutterSize,
//                                               left: gutterSize,
//                                               bottom: gutterSize,
//                                               right: gutterSize)
//        collectionView.setCollectionViewLayout(flowLayout, animated: false)
//    }
//}
//
//extension PortfolioViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.portfolioListings.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.reuseIdentifier(),
//                                                            for: indexPath) as? ImageViewCell else {
//            fatalError()
//        }
//        let imageUrl = viewModel.portfolioListings[indexPath.row].imageUrl
//        cell.setImageUrl(imageUrl)
//        return cell
//    }
//}
//
//extension PortfolioViewController:UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.alpha = 0.5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.alpha = 1.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let associatedObject = viewModel.portfolioListings[indexPath.row].associatedObject
//        eventHandler.didSelectAssociatedObject(associatedObject)
//    }
//}
