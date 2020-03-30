import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIRefreshControl {
    var isRefreshingAnimated: Binder<Bool> {
        return Binder(self.base) { refreshControl, refresh in
            if refresh {
                refreshControl.beginRefreshingWithAnimation()
            } else {
                refreshControl.endRefreshing()
            }
        }
    }
}

// Needed due to a bug in the beginRefreshing method
// https://stackoverflow.com/questions/14718850/uirefreshcontrol-beginrefreshing-not-working-when-uitableviewcontroller-is-ins
private extension UIRefreshControl {
    func beginRefreshingWithAnimation() {
        guard let scrollView = superview as? UIScrollView else {
            return
        }

        let offset = CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height)

        self.beginRefreshing()
        self.alpha = 0

        UIView.animate(withDuration: 0.3) {
            scrollView.contentOffset = offset
            self.alpha = 1
        }
    }
}
