import UIKit
import Combine

extension UIRefreshControl: SimpleSubscriber {

    public func recieve(_ input: Bool) {

        switch (input, isRefreshing) {
        case (true, false):
            beginRefreshingWithAnimation()
        case (false, true):
            endRefreshing()
        default:
            break
        }
    }
}

