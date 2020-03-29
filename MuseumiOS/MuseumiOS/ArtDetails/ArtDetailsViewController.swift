import Combine
import MuseumApp
import SDWebImage
import UIKit
import Utils

class ArtDetailsViewController: UIViewController {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.edgesToSuperview()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private var subscriptions = Set<AnyCancellable>()

    private let viewModel: ArtDetailsViewModel

    init(viewModel: ArtDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) required init?(coder _: NSCoder) {
        fatalError("Not implemented")
    }
}

extension ArtDetailsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
    }
}

private extension ArtDetailsViewController {
    func bind() {
        viewModel.$imageURL
            .receive(on: RunLoop.main)
            .sink { self.imageView.sd_setImage(with: $0) }
            .store(in: &subscriptions)
    }
}
