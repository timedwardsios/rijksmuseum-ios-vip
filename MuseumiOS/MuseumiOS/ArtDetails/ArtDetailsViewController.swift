import MuseumApp
import SDWebImage
import UIKit
import Utils
import RxSwift
import RxCocoa

class ArtDetailsViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.edgesToSuperview()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let disposeBag = DisposeBag()

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
}

private extension ArtDetailsViewController {
    func bind() {
        viewModel.outputs.imageURL
            .asDriver()
            .drive(onNext: {
                self.imageView.sd_setImage(with: $0)
            })
            .disposed(by: disposeBag)
    }
}
