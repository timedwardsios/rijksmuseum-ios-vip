
import XCTest
@testable import Rijksmuseum

class PortfolioViewControllerTests: XCTestCase {
    // MARK: mocks
    class InteractorMock: PortfolioInteractorInterface {
        func fetchListings(request: Portfolio.FetchListings.Request) {}

        var numberOfListings_exp:XCTestExpectation?
        func numberOfListings() -> Int {
            numberOfListings_exp?.fulfill()
            return 1
        }

        var imageUrlForListingAtIndex_exp:XCTestExpectation?
        func imageUrlForListingAtIndex(_ index: Int) -> URL? {
            imageUrlForListingAtIndex_exp?.fulfill()
            return SharedMockData.ArtPrimitiveMock().imageUrl
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
        let exp1 = XCTestExpectation(description: "CollectionView should ask for count")
        let exp2 = XCTestExpectation(description: "CollectionView should ask for cells")
        let viewModel = Portfolio.FetchListings.ViewModel(viewState: .loaded(true),
                                                          highlightedIndex:nil)
        // when
        interactor.numberOfListings_exp = exp1
        interactor.imageUrlForListingAtIndex_exp = exp2
        sut.viewModel = viewModel
        // then
        wait(for: [exp1, exp2], timeout: 1)
    }

    func test_updateViewModel_error(){
        // given
        let viewModel = Portfolio.FetchListings.ViewModel(viewState: .error("Error!"),
                                                          highlightedIndex:nil)
        // when
        sut.viewModel = viewModel
    }

    func test_didHighlightItem_forwarded_interactor(){
        // given
        let row = 0
        // when
        sut.collectionView(sut.rootView.collectionView,
                           didHighlightItemAt: IndexPath(row: row, section: 0))
        // then
        XCTAssert(interactor.setHighlightedIndex_value == row,
                  "Highlighting a cell should update interactor")
    }

    func test_didUnhighlightItem_forwarded_interactor(){
        // given
        let row = 0
        // when
        sut.collectionView(sut.rootView.collectionView,
                           didUnhighlightItemAt: IndexPath(row: row, section: 0))
        // then
        XCTAssert(interactor.setHighlightedIndex_value == nil,
                  "Unhighlighting a cell should update interactor")
    }

    func test_didSelectItem_forwarded_interactor(){
        // given
        let row = 0
        // when
        sut.collectionView(sut.rootView.collectionView,
                           didSelectItemAt: IndexPath(row: row, section: 0))
        // then
        XCTAssert(interactor.setSelectedIndex_value == row,
                  "Selecting a cell should update interactor")
    }
}
