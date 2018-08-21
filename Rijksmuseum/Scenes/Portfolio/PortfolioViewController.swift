
import UIKit

class PortfolioViewController: UIViewController{
    let interactor: PortfolioInteractorInput
    let router: PortfolioRouterInput
    init(interactor: PortfolioInteractorInput,
         router: PortfolioRouterInput){
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {fatalError()}

    let rootView = PortfolioView()
    var imageUrls = [URL]()

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Rijksmuseum"
        rootView.collectionView.dataSource = self
        rootView.collectionView.delegate = self
        rootView.refreshControl.addTarget(self,
                                          action: #selector(fetchArt),
                                          for: .valueChanged)
        fetchArt()
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
    }

    func collectionView(_ collectionView: UICollectionView,
                        didUnhighlightItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
    }
}

extension PortfolioViewController:PortfolioViewControllerInput {
    func displayFetchArt(viewModel: Portfolio.FetchArt.ViewModel) {
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
}

private extension PortfolioViewController {
    func beginRefreshing(){
        self.rootView.refreshControl.beginRefreshingProgramatically()
    }

    func endRefreshing(){
        rootView.refreshControl.endRefreshing()
    }

    func setImageUrls(_ imageUrls:[URL]){
        self.imageUrls = imageUrls
        rootView.collectionView.reloadData()
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

// MARK: actions
@objc private extension PortfolioViewController {
    func fetchArt() {
        interactor.performFetchArt(request: Portfolio.FetchArt.Request())
    }
}
