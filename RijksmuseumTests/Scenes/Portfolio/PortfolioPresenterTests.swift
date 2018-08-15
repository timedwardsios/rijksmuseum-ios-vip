
import XCTest
@testable import Rijksmuseum

class PortfolioPresenterTests: XCTestCase {
    // MARK: mocks
    class ViewControllerMock: PortfolioViewControllerInterface {
        var viewModel = Portfolio.FetchListings.ViewModel(viewState: .loading,
                                                          highlightedIndex: nil)
    }

    // MARK: init
    var sut: PortfolioPresenter!
    var viewController: ViewControllerMock!
    override func setUp() {
        super.setUp()
        viewController = ViewControllerMock()
        sut = PortfolioPresenter()
        sut.viewController = viewController
    }

    // MARK: tests
    func test_presentListings_success(){
        // when
        sut.presentListings(response: Portfolio.FetchListings.Response(result: .success([])))
        // then
        if case .loaded(let newData) = viewController.viewModel.viewState {
            XCTAssert(newData == true,
                      "New data from the interactor should be flagged in the ViewModel")
        } else {
            XCTFail("View model should reflect loaded state")
        }
    }

    func test_presentListings_failure(){
        // when
        let error = Seeds.ErrorSeed()
        sut.presentListings(response: Portfolio.FetchListings.Response(result: .failure(error)))
        // then
        guard case .error = viewController.viewModel.viewState else {
            XCTFail("View model should reflect error state")
            return
        }
    }
    
    func test_presentHighlightedIndex_none(){
        // when
        sut.presentHighlightedIndex(nil)
        // then
        XCTAssert(viewController.viewModel.highlightedIndex == nil,
                  "No index in the interactor should be forwarded")
    }

    func test_presentHighlightedIndex_some(){
        // when
        sut.presentHighlightedIndex(0)
        // then
        XCTAssert(viewController.viewModel.highlightedIndex == 0,
                  "Correct index in the interactor should be forwarded")
    }
}
