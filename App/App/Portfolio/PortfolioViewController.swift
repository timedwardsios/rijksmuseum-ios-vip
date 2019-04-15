import UIKit
import Utils

class PortfolioViewController: UICollectionViewController {

    let interacting: PortfolioInteraction
    let routing: PortfolioRouting

    init(interacting: PortfolioInteraction,
         routing: PortfolioRouting){
        self.interacting = interacting
        self.routing = routing
        super.init(collectionViewLayout: UICollectionViewLayout())
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {fatalError()}

    let refreshControl = UIRefreshControl()

    var imageUrls = [URL]()
}

// MARK: - Overrides
extension PortfolioDisplay{
    override func viewDidLoad(){
        super.viewDidLoad()
        setupSubviews()
        title = "Rijksmuseum"
        collectionView.dataSource = self
        collectionView.delegate = self
        refreshControl.addTarget(self,
                                 action: #selector(didPullToRefresh),
                                 for: .valueChanged)
        interacting.fetchArts()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateCollectionViewLayout()
    }
}

// MARK: - UICollectionViewDataSource
extension PortfolioDisplay {
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
        imageViewCell.imageUrl = imageUrls[indexPath.row]
        return imageViewCell
    }
}

// MARK: - UICollectionViewDelegate
extension PortfolioDisplay {
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
        routing.navigateToListing()
    }
}

extension PortfolioDisplay: PortfolioDisplaying {
    func displayArts(state: State<[URL]>) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            switch state {
            case .loading:
                self.refreshControl.beginRefreshingProgramatically()
            case .loaded(let imageUrls):
                self.refreshControl.endRefreshing()
                self.setImageUrls(imageUrls)
            case .error(let error):
                self.refreshControl.endRefreshing()
                self.displayErrorMessage(error.localizedDescription)
            }
        }
    }
}

// MARK: - Private methods
private extension PortfolioDisplay {

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

    func setImageUrls(_ imageUrls:[URL]){
        self.imageUrls = imageUrls
        collectionView.reloadData()
    }

    func displayErrorMessage(_ message:String){
        let alertViewController = UIAlertController(title: "Error",
                                                    message: message,
                                                    preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        alertViewController.addAction(okAction)
        self.present(alertViewController,
                     animated: true,
                     completion: nil)
    }
}

// MARK: - Selectors
@objc extension PortfolioDisplay {
    func didPullToRefresh() {
        interactor.fetchArt()
    }
}
