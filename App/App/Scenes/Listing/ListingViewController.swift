
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
        output.performLoadArt(request: Listing.LoadArt.Request())
    }
}

extension ListingViewController:ListingViewControllerInput {
    func displayLoadArt(viewModel: Listing.LoadArt.ViewModel) {
        rootView.imageView.sd_setImage(with: viewModel.imageUrl,
                                       completed: nil)
    }
}
