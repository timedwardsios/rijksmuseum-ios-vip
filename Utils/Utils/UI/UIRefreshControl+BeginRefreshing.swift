import UIKit

public extension UIRefreshControl {

    func beginRefreshingWithAnimation() {

        guard let scrollView = superview as? UIScrollView else {
            return
        }

        let offset = CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height)

        UIView.animate(
            withDuration: 0,
            animations: {
                scrollView.contentOffset = offset
            },
            completion: { finished in
                if finished == true {
                    self.beginRefreshing()
                }
            }
        )
    }
}
