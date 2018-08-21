
import UIKit

// MARK: init
class PortfolioViewController: UIViewController, PortfolioViewControllerInterface{
    let interactor: PortfolioInteractorInterface
    let router: PortfolioRouterInterface
    init(interactor: PortfolioInteractorInterface,
         router: PortfolioRouterInterface){
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {fatalError()}

    let rootView = PortfolioView()
    var imageUrls = [URL]()
}

// MARK: methods
extension PortfolioViewController {
    override func loadView() {
        view = rootView
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Rijksmuseum"
        rootView.collectionView.dataSource = self
        rootView.collectionView.delegate = self
        rootView.refreshControl.addTarget(self,
                                          action: #selector(fetchListings),
                                          for: .valueChanged)
        fetchListings()
    }
}

// MARK: actions
extension PortfolioViewController {
    @objc func fetchListings() {
        interactor.performFetchListings(request: Portfolio.FetchListings.Request())
    }
}

// MARK: UICollectionViewDataSource
extension PortfolioViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }

    func collectionView(_ collectionView: UICollectionView,
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

// MARK: UICollectionViewDelegate
extension PortfolioViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView,
                        didHighlightItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView,
                        didUnhighlightItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: FetchListings
extension PortfolioViewController {
    func displayFetchListings(viewModel: Portfolio.FetchListings.ViewModel) {
        switch viewModel.state {
        case .loading:
            beginRefreshing()
        case .loaded(let imageUrls):
            endRefreshing()
            setImageUrls(imageUrls)
        case .error(let message):
            endRefreshing()
            displayErrorMessage(message)
        }
    }

    private func beginRefreshing(){
        self.rootView.refreshControl.beginRefreshingProgramatically()
    }

    private func endRefreshing(){
        rootView.refreshControl.endRefreshing()
    }

    private func setImageUrls(_ imageUrls:[URL]){
        self.imageUrls = imageUrls
        rootView.collectionView.reloadData()
    }

    private func displayErrorMessage(_ message:String){
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
