
import XCTest
@testable import Rijksmuseum

class PortfolioPresenterTests: XCTestCase {
    class ViewControllerMock: PortfolioViewControllerInterface {
        var viewModel: Portfolio.FetchListings.ViewModel = 
    }

    var sut: PortfolioPresenter!
    var viewController = ViewControllerMock()
    override func setUp() {
        super.setUp()
        self.sut = PortfolioPresenter()
        sut.viewController = viewController
    }

    func test_presentListings_success(){
        sut.presentListings(response: Portfolio.FetchListings.Response(result: .success([])))
        if case .loaded = viewController.viewModel!.viewState {} else {
            XCTAssert(false)
        }

    }

    func test_presentListings_failure(){
        struct TestError:Error {}
        sut.presentListings(response: Portfolio.FetchListings.Response(result: .failure(TestError())))
        if case .error = viewController.viewModel!.viewState {} else {
            XCTAssert(false)
        }
    }
}
