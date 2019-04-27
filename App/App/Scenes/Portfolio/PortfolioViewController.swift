
import UIKit
import Utils

class PortfolioViewController: UICollectionViewController {

    var interactor: PortfolioInteracting?
    var router: PortfolioRouting?

    private let refreshControl = UIRefreshControl()

    private var imageUrls = [URL](){
        didSet{
            collectionView.reloadData()
        }
    }
}

// MARK: - Overrides
extension PortfolioViewController{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupSubviews()
        title = "Rijksmuseum"
        collectionView.dataSource = self
        collectionView.delegate = self
        refreshControl.addTarget(self,
                                 action: #selector(didPullToRefresh),
                                 for: .valueChanged)
        interactor?.fetchArts()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateCollectionViewLayout()
    }
}

// MARK: - UICollectionViewDataSource
extension PortfolioViewController {
    override func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseId = ImageViewCell.reuseIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId,
                                                      for: indexPath)
        guard let imageViewCell = cell as? ImageViewCell else {
            return cell
        }
        guard imageUrls.indices.contains(indexPath.row) else {
            return imageViewCell
        }
        imageViewCell.setImageURL(imageUrls[safe: indexPath.row])
        return imageViewCell
    }
}

// MARK: - UICollectionViewDelegate
extension PortfolioViewController {
    override func collectionView(_ collectionView: UICollectionView,
                        didHighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 0.5
    }

    override func collectionView(_ collectionView: UICollectionView,
                        didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 1
    }

    override func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        interactor?.selectArt(atIndex: indexPath.row)
        router?.routeToListing()
    }
}

extension PortfolioViewController: PortfolioDisplaying {
    func displayIsLoading(_ isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            if isLoading {
                self?.refreshControl.beginRefreshingProgramatically()
            } else {
                self?.refreshControl.endRefreshing()
            }
        }
    }

    func displayImageUrls(_ urls: [URL]) {
        DispatchQueue.main.async { [weak self] in
            self?.imageUrls = urls
        }
    }

    func displayErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            let alertViewController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertViewController.addAction(okAction)
            self.present(alertViewController, animated: true)
        }
    }
}

private extension PortfolioViewController {

    func setupSubviews(){
        view.backgroundColor = UIColor(hex: "343537")
        refreshControl.tintColor = .white
        collectionView.refreshControl = refreshControl
        collectionView.alwaysBounceVertical = true
        collectionView.register(ImageViewCell.self,
                                forCellWithReuseIdentifier: ImageViewCell.reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.edges(to: view)
    }

    func updateCollectionViewLayout(){
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

    @objc func didPullToRefresh() {
        interactor?.fetchArts()
    }
}
