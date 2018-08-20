
import UIKit

class PortfolioViewController: UIViewController{
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

// MARK: selectors
extension PortfolioViewController {
    @objc func fetchListings() {
        interactor.performFetchListings(request: Portfolio.FetchListings.Request())
    }
}

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

extension PortfolioViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView,
                        didHighlightItemAt indexPath: IndexPath) {
//        interactor.setHighlightedIndex(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView,
                        didUnhighlightItemAt indexPath: IndexPath) {
//        interactor.setHighlightedIndex(nil)
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
//        interactor.setSelectedIndex(indexPath.row)
    }
}

extension PortfolioViewController: PortfolioViewControllerInterface {
    func displayFetchListings(viewModel: Portfolio.FetchListings.ViewModel) {
        switch viewModel.state {
        case .loading:
            beginRefreshing()
        case .loaded(let imageUrls):
            endRefreshing()
            self.imageUrls = imageUrls
        case .error(let message):
            endRefreshing()
            displayErrorMessage(message)
        }
    }

    func beginRefreshing(){
        self.rootView.refreshControl.beginRefreshingProgramatically()
    }

    func endRefreshing(){
        rootView.refreshControl.endRefreshing()
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


//    func willSetViewModel() {
//        if let highlighedIndex = viewModel.highlightedIndex {
//            if let cell = self.rootView.collectionView.cellForItem(at: IndexPath(row: highlighedIndex,
//                                                                                 section: 0)){
//                cell.alpha = 1.0
//            }
//        }
//    }
//
//    func didSetViewModel(){
//        switch viewModel.viewState {
//        case .loading:
//            break
//        case .loaded(_):
//            rootView.collectionView.reloadData()
//        case .error(_):
//            break
//        }
//        if let index = viewModel.highlightedIndex,
//            let cell = rootView.collectionView.cellForItem(at: IndexPath(row: index, section: 0)){
//            cell.alpha = 0.5
//        }
//    }
}
