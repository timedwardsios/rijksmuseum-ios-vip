import UIKit
import TimKit
import Combine
import SDWebImage

class DetailsView: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    private let viewModel: DetailsView.Model

    private var tokens = Set<AnyCancellable>()

    required init?(coder: NSCoder, viewModel: DetailsView.Model) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailsView {
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

private extension DetailsView {
    func bind() {
        viewModel.$imageURL
            .receive(on: RunLoop.main)
            .subscribe(imageView)
    }
}


extension UIImageView: SimpleSubscriber {
    public func recieve(_ input: URL) {
        sd_setImage(with: input)
    }
}
