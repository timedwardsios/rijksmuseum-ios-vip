
import XCTest
@testable import Rijksmuseum

class PortfolioViewControllerTests: XCTestCase {
    // MARK: mocks
    class InteractorMock: PortfolioInteractorInterface {
        func fetchListings(request: Portfolio.FetchListings.Request) {}

        func numberOfListings() -> Int {
            return 1
        }

        var imageUrlForListingAtIndex_expectation:XCTestExpectation?
        func imageUrlForListingAtIndex(_ index: Int) -> URL? {
            imageUrlForListingAtIndex_expectation?.fulfill()
            return URL(string: "http://www.google.com")!
        }

        var setHighlightedIndex_value:Int?
        func setHighlightedIndex(_ index: Int?) {
            setHighlightedIndex_value = index
        }

        var setSelectedIndex_value:Int?
        func setSelectedIndex(_ index: Int) {
            setSelectedIndex_value = index
        }
    }

    class RouterMock: PortfolioRouterInterface {
        var dataStore: PortfolioDataStore?
    }

    // MARK: init
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

    // MARK: tests
    func test_updateViewModel_loading(){
        // when
        sut.viewModel = Portfolio.FetchListings.ViewModel(viewState: .loading,
                                                          highlightedIndex:nil)
    }

    func test_updateViewModel_loaded(){
        // given
        let exp = XCTestExpectation(description: "Load collection view")
        let newData = true
        // when
        interactor.imageUrlForListingAtIndex_expectation = exp
        sut.viewModel = Portfolio.FetchListings.ViewModel(viewState: .loaded(newData),
                                                          highlightedIndex:nil)
        // then
        wait(for: [exp], timeout: 1)
    }

    func test_updateViewModel_error(){
        // given
        let errorMessage = "Something went wrong"
        let viewModel = Portfolio.FetchListings.ViewModel(viewState: .error(errorMessage),
                                                          highlightedIndex:nil)
        // when
        sut.viewModel = viewModel
    }

    func test_didHighlightItem(){
        // given
        let row = 0
        // when
        sut.collectionView(sut.rootView.collectionView,
                           didHighlightItemAt: IndexPath(row: row, section: 0))
        // then
        XCTAssert(interactor.setHighlightedIndex_value == row)
    }

    func test_didUnhighlightItem(){
        // given
        let row = 0
        // when
        sut.collectionView(sut.rootView.collectionView,
                           didUnhighlightItemAt: IndexPath(row: row, section: 0))
        // then
        XCTAssert(interactor.setHighlightedIndex_value == nil)
    }

    func test_didSelectItem(){
        // given
        let row = 0
        // when
        sut.collectionView(sut.rootView.collectionView,
                           didSelectItemAt: IndexPath(row: row, section: 0))
        // then
        XCTAssert(interactor.setSelectedIndex_value == row)
    }
}
