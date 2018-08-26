
import UIKit
import Utils

class ListingViewController: UIViewController{
    let output: ListingViewControllerOutput
    let router: ListingRouterProtocol
    init(output: ListingViewControllerOutput,
         router: ListingRouterProtocol){
        self.output = output
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

extension ListingViewController:ListingViewControllerInput {
    //
}

private extension ListingViewController {
    //
}

@objc private extension ListingViewController {
    //
}
