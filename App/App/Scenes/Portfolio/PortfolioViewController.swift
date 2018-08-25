
import UIKit
import Utils

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
        collectionView.cellForItem(at: indexPath)?.alpha = 0.5
    }

    func collectionView(_ collectionView: UICollectionView,
                        didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        interactor.selectArt(request: PortfolioScene.SelectArt.Request(index: indexPath.row))
        router.navigateToListingScene()
    }
}

extension PortfolioViewController:PortfolioViewControllerInterface {
    func displayFetchArt(viewModel: PortfolioScene.FetchArt.ViewModel) {
        DispatchQueue.main.async {
            self.unpackViewModel(viewModel)
        }
    }
}

private extension PortfolioViewController {
    func unpackViewModel(_ viewModel:PortfolioScene.FetchArt.ViewModel){
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

@objc private extension PortfolioViewController {
    func fetchArt() {
        interactor.fetchArt(request: PortfolioScene.FetchArt.Request())
    }
}
