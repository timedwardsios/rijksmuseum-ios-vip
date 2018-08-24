
import UIKit

class ListingRouter{
    weak var viewController: ListingViewController?
    let dataStore: ListingDataInterface
    init(dataStore:ListingDataInterface){
        self.dataStore = dataStore
    }
}

extension ListingRouter: ListingRouterInterface{
    //
}
