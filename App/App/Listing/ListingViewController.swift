
import UIKit
import SDWebImage

class ListingViewController: UIViewController{

    let interactor: ListingInteracting
    let router: ListingRouting

    let imageView = UIImageView()

    init(interactor: ListingInteractor,
         router: ListingRouting){
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {fatalError()}

    override func viewDidLoad(){
        super.viewDidLoad()
        setupSubviews()
        title = "Rijksmuseum"
        interactor.loadArtRequest(.init())
    }
}

private extension ListingViewController {
    func setupSubviews(){
        view.backgroundColor = UIColor(hex: "343537")
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.edges(to: view)
    }
}

extension ListingViewController: ListingView {
    func loadArtViewModel(_ viewModel: Listing.LoadArt.ViewModel) {
        imageView.sd_setImage(with: viewModel.imageUrl,
                                       completed: nil)
    }
}
