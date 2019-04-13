
import UIKit
import Utils

class PortfolioViewController: UICollectionViewController {

    let interactor: PortfolioInteracting

    let router: PortfolioRouting

    init(interactor: PortfolioInteracting,
         router: PortfolioRouting){
        self.interactor = interactor
        self.router = router
        super.init(collectionViewLayout: UICollectionViewLayout())
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {fatalError()}

    let refreshControl = UIRefreshControl()

    var imageUrls = [URL]()
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
                                          action: #selector(fetchArt),
                                          for: .valueChanged)
        fetchArt()
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
        let reuseId = ImageViewCell.reuseIdentifier()
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
//        interactor.performSelectArt(request: Portfolio.SelectArt.Request(index: indexPath.row))
        router.navigateToListing()
    }
}

extension PortfolioViewController: PortfolioView {
    func setViewModel(_ viewModel: Portfolio.ViewModel) {
        DispatchQueue.main.async {
            self.unpackViewModel(viewModel)
        }
    }
}

// MARK: - Private methods
private extension PortfolioViewController {

    func setupSubviews(){
        view.backgroundColor = UIColor(hex: "343537")
        refreshControl.tintColor = .white
        collectionView.refreshControl = refreshControl
        collectionView.alwaysBounceVertical = true
        collectionView.register(ImageViewCell.self,
                                forCellWithReuseIdentifier: ImageViewCell.reuseIdentifier())
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

    func unpackViewModel(_ viewModel:Portfolio.ViewModel){
        switch viewModel.state {
        case .loading:
            self.beginRefreshing()
        case .loaded(let imageUrls):
            self.endRefreshing()
            self.setImageUrls(imageUrls)
        case .error(let message):
            self.endRefreshing()
            self.displayErrorMessage(message)
        }
    }

    func beginRefreshing(){
        refreshControl.beginRefreshingProgramatically()
    }

    func endRefreshing(){
        refreshControl.endRefreshing()
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
@objc extension PortfolioViewController {
    func fetchArt() {
        interactor.performFetchArt(request: Portfolio.FetchArt.Request())
    }
}
