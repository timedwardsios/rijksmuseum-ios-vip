
import UIKit
import TinyConstraints
import SDWebImage

public class ImageViewCell: UICollectionViewCell {
    public var imageUrl:URL?{
        didSet{
            imageView.sd_cancelCurrentImageLoad()
            imageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }

    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews(){
        contentView.backgroundColor = .lightGray

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        imageView.edges(to: self)
    }
}
