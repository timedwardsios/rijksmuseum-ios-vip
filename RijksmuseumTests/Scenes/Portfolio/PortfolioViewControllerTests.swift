
import XCTest
@testable import Rijksmuseum

class PortfolioViewControllerTests: XCTestCase {
    class InteractorMock: PortfolioInteractorInterface {

        var imageUrlForListingAtIndex_expectation:XCTestExpectation?

        func fetchListings(request: Portfolio.FetchListings.Request) {}

        func numberOfListings() -> Int {
            return 1
        }

        func imageUrlForListingAtIndex(_ index: Int) -> URL? {
            imageUrlForListingAtIndex_expectation?.fulfill()
            return URL(string: "http://www.google.com")!
        }

        func setSelectedRow(_ row: Int) {}
    }

    class RouterMock: PortfolioRouterInterface {
        var dataStore: PortfolioDataStore?
    }

    var sut:PortfolioViewController!
    var interactor:InteractorMock!
    var router:RouterMock!
    var window:UIWindow!
    override func setUp() {
        super.setUp()
        interactor = InteractorMock()
        router = RouterMock()
        self.sut = PortfolioViewController(interactor: interactor,
                                           router: router)
        window = UIWindow()
        window.rootViewController = sut
        window.makeKeyAndVisible()
        sut.view.layoutSubviews()
    }

    func test_updateViewModel_loading(){
        sut.updateViewModel(viewModel: Portfolio.FetchListings.ViewModel(viewState: .loading))
    }

    func test_updateViewModel_loaded(){
        let exp = XCTestExpectation(description: "Loads collection view")
        interactor.imageUrlForListingAtIndex_expectation = exp
        sut.updateViewModel(viewModel: Portfolio.FetchListings.ViewModel(viewState: .loaded))
        wait(for: [exp], timeout: 1)
    }

    func test_updateViewModel_error(){
        sut.updateViewModel(viewModel: Portfolio.FetchListings.ViewModel(viewState: .error("Something went wrong")))
    }

    func test_didHighlightItem(){
        sut.updateViewModel(viewModel: Portfolio.FetchListings.ViewModel(viewState: .loaded))

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.rootView.collectionView.cellForItem(at: indexPath)
    }
}
