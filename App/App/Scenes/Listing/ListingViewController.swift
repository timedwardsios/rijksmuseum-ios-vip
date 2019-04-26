
import UIKit
import SDWebImage

class ListingViewController: UIViewController{

    let interactor: ListingInteracting

    let imageView = UIImageView()

    init(interactor: ListingInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {fatalError()}

    override func viewDidLoad(){
        super.viewDidLoad()
        setupSubviews()
        title = "Rijksmuseum"
        interactor.processRequest(.loadArt)
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

extension ListingViewController: ListingDisplaying {

    func displayViewModel(_ viewModel: ListingViewModel) {
        switch viewModel {
        case .imageUrl(let url):
            imageView.sd_setImage(with: url,
                                  completed: nil)
        }
    }
}
