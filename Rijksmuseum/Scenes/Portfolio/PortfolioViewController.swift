
import UIKit

protocol PortfolioViewControllerInterface: class{
    var viewModel:Portfolio.FetchListings.ViewModel{get set}
}

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

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Rijksmuseum"
        rootView.collectionView.dataSource = self
        rootView.collectionView.delegate = self
        interactor.fetchListings(request: Portfolio.FetchListings.Request())
    }

    var viewModel = Portfolio.FetchListings.ViewModel(viewState: .loading) {
        willSet{willSetViewModel()}
        didSet{didSetViewModel()}
    }
}

extension PortfolioViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard case .loaded(let urls) = viewModel.viewState else{
            return 0
        }
        return urls.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseId = ImageViewCell.reuseIdentifier()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId,
                                                      for: indexPath)
        guard let imageViewCell = cell as? ImageViewCell else {
            return cell
        }
        guard case .loaded(let urls) = viewModel.viewState else{
            return imageViewCell
        }
        if !urls.indices.contains(indexPath.row){
            return imageViewCell
        }
        imageViewCell.imageUrl = urls[indexPath.row]
        return imageViewCell
    }
}

extension PortfolioViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView,
                        didHighlightItemAt indexPath: IndexPath) {
        interactor.setHighlightedIndex(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView,
                        didUnhighlightItemAt indexPath: IndexPath) {
        interactor.setHighlightedIndex(nil)
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        interactor.setSelectedIndex(indexPath.row)
    }
}

extension PortfolioViewController {
    func willSetViewModel() {
        if let index = self.viewModel.highlightedIndex,
            let cell = self.rootView.collectionView.cellForItem(at: IndexPath(row: index,
                                                                              section: 0)){
            cell.alpha = 1.0
        }
    }

    func didSetViewModel(){
        switch viewModel.viewState {
        case .loading:
            break
        case .loaded(let newData):
            if newData == true {
                rootView.collectionView.reloadData()
            }
        case .error(_):
            break
        }
        if let index = viewModel.highlightedIndex,
            let cell = rootView.collectionView.cellForItem(at: IndexPath(row: index, section: 0)){
            cell.alpha = 0.5
        }
    }
}
