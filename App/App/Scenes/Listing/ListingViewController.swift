
import UIKit
import Utils

class ListingViewController: UIViewController{
    let interactor: ListingInteractorProtocol
    let router: ListingRouterProtocol
    init(interactor: ListingInteractorProtocol,
         router: ListingRouterProtocol){
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

extension ListingViewController:ListingViewControllerProtocol {
    //
}

private extension ListingViewController {
    //
}

@objc private extension ListingViewController {
    //
}
