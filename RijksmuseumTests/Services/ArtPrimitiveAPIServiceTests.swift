
import XCTest
@testable import Rijksmuseum

//class PortfolioPresenterTests: XCTestCase {
//    // MARK: mocks
//    class ViewControllerMock: PortfolioViewControllerInterface {
//        var viewModel = Portfolio.FetchListings.ViewModel(viewState: .loading,
//                                                          highlightedIndex: nil)
//    }
//
//    // MARK: init
//    var sut: PortfolioPresenter!
//    var viewController = ViewControllerMock()
//    override func setUp() {
//        super.setUp()
//        self.sut = PortfolioPresenter()
//        sut.viewController = viewController
//    }
//
//    // MARK: tests
//    func test_presentListings_success(){
//        // when
//        sut.presentListings(response: Portfolio.FetchListings.Response(result: .success([])))
//        // then
//        if case .loaded(let newData) = viewController.viewModel.viewState {
//            XCTAssert(newData == true)
//        } else {
//            XCTAssert(false)
//        }
//
//    }
//
//    func test_presentListings_failure(){
//        // given
//        struct TestError:Error {}
//        // when
//        sut.presentListings(response: Portfolio.FetchListings.Response(result: .failure(TestError())))
//        // then
//        if case .error = viewController.viewModel.viewState {} else {
//            XCTAssert(false)
//        }
//    }
//
//    func test_presentHighlightedIndex_none(){
//        // when
//        sut.presentHighlightedIndex(nil)
//        // then
//        XCTAssert(viewController.viewModel.highlightedIndex == nil)
//    }
//
//    func test_presentHighlightedIndex_some(){
//        // when
//        sut.presentHighlightedIndex(0)
//        // then
//        XCTAssert(viewController.viewModel.highlightedIndex == 0)
//    }
//}
