
import UIKit
import TinyConstraints
import SDWebImage

class ImageViewCell: UICollectionViewCell {

    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImageURL(_ url:URL?) {
        imageView.sd_cancelCurrentImageLoad()
        imageView.sd_setImage(with: url, completed: nil)
    }

    private func setupSubviews(){
        contentView.backgroundColor = .lightGray
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        imageView.edges(to: self)
    }
}
