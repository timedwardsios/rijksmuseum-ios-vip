//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

// responsible for UI, delegating UI callbacks, nothing more.

import UIKit
import TinyConstraints

class PortfolioView: UIViewController, PortfolioInterface {
    var viewModel: PortfolioViewModel {
        didSet {
            //
        }
    }

    let eventHandler:PortfolioEventHandler
    let collectionView:UICollectionView

    init(eventHandler:PortfolioEventHandler) {
        self.viewModel = PortfolioViewModel(imageUrls: [URL]())
        self.eventHandler = eventHandler
        self.collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewFlowLayout())
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PortfolioViewCell.self,
                                forCellWithReuseIdentifier: PortfolioViewCell.reuseIdentifier())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.edges(to: view)

        title = "Rijksmuseum"

        eventHandler.didLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        //
    }

    override func viewDidDisappear(_ animated: Bool) {
        //
    }
}

extension PortfolioView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PortfolioViewCell.reuseIdentifier(),
                                                            for: indexPath) as? PortfolioViewCell else {
            fatalError()
        }
        let imageUrl = viewModel.imageUrls[indexPath.row]
        cell.viewModel = PortfolioViewCell.ViewModel(imageUrl: imageUrl)
        cell.backgroundColor = .lightGray
        return cell
    }
}

extension PortfolioView:UICollectionViewDelegate{
    //
}

extension PortfolioView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 44, height: 44)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}



//        let artRequest = ArtRequest(page: 0, starredOnly: false)
//        artService.getArtResults(withRequest: artRequest) {[weak self] (result) in
//            guard let sSelf = self else {return}
//            switch result {
//            case .success(let artObjects):
//                sSelf.artObjects = artObjects
//                DispatchQueue.main.async {
//                    sSelf.collectionView.reloadData()
//                }
//            case .failure(_):
//                fatalError()
//            }
//        }
