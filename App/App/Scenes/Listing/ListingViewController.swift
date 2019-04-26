
import UIKit
import SDWebImage

class ListingViewController: UIViewController{

    let processRequest: (ListingRequest)->Void

    let imageView = UIImageView()

    init(processRequest: @escaping (ListingRequest)->Void) {
        self.processRequest = processRequest
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {fatalError()}

    override func viewDidLoad(){
        super.viewDidLoad()
        setupSubviews()
        title = "Rijksmuseum"
        processRequest(.loadArt)
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

extension ListingViewController {
    func displayViewModel(viewModel: ListingViewModel) {
        switch viewModel {
        case .imageUrl(let url):
            imageView.sd_setImage(with: url,
                                  completed: nil)
        }
    }
}
