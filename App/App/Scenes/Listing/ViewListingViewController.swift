
import UIKit
import Utilities

class ListingViewController: UIViewController{
    let interactor: ListingInteractorInterface
    let router: ListingRouterInterface
    init(interactor: ListingInteractorInterface,
         router: ListingRouterInterface){
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {fatalError()}

    let rootView = ListingView()

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Rijksmuseum"
    }
}

extension ListingViewController:ListingViewControllerInterface {
    //
}

private extension ListingViewController {
    //
}

@objc private extension ListingViewController {
    //
}
