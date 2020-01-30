import UIKit

public extension UIRefreshControl {

    func beginRefreshingWithAnimation() {

        guard let scrollView = self.superview as? UIScrollView else {
            return
        }

        let offset = CGPoint(x: 0, y: scrollView.contentOffset.y - self.frame.height)

        UIView.animate(withDuration: 0, animations: {

            scrollView.contentOffset = offset

        }) { (finished) in

            if finished == true {
                self.beginRefreshing()
            }
        }
    }
}
