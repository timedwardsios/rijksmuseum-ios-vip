
import UIKit

class ListingRouter{

    let dependencies: Dependencies
    let dataStore: ListingDataStore
    weak var viewController: ListingViewController?

    init(dependencies: Dependencies,
         dataStore:ListingDataStore,
         viewController: ListingViewController? = nil){
        self.dependencies = dependencies
        self.dataStore = dataStore
        self.viewController = viewController
    }
}

extension ListingRouter: ListingRouting {}
