
import UIKit
import TinyConstraints
import Utils

class ListingView: UIView{
    let imageView = UIImageView()
    init() {
        super.init(frame: .zero)
        setupSubviews()
    }
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {fatalError()}
}

private extension ListingView {
    func setupSubviews(){
        backgroundColor = UIColor(hex: "343537")

        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        imageView.edges(to: self)
    }
}
