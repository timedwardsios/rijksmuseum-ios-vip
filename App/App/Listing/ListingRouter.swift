
import UIKit

class ListingRouter{
    weak var viewController: ListingViewController?
    let dataStore:ListingDataStore
    init(dataStore:ListingDataStore){
        self.dataStore = dataStore
    }
}

extension ListingRouter: ListingRouterProtocol{}
