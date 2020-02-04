import UIKit
import TimKit
import Combine
import SDWebImage
import MuseumApp

class ArtDetailsViewController: UIViewController {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.edgesToSuperview()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private var tokens = Set<AnyCancellable>()

    private let artID: String
    private let presenter: ArtDetailsPresenter

    init(artID: String,
         presenter: ArtDetailsPresenter) {
        self.artID = artID
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) { fatalError() }
}

extension ArtDetailsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        bind()
    }
}

private extension ArtDetailsViewController {
    func bind() {
        presenter.model
            .receive(on: RunLoop.main)
            .compactMap { $0.imageURL }
            // Uncomment after loading images manually
//            .subscribe(imageView)
            .sink {self.imageView.sd_setImage(with: $0)}
            .store(in: &tokens)
    }
}
