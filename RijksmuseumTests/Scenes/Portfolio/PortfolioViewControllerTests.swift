
import XCTest
@testable import Rijksmuseum

class PortfolioViewControllerTests: XCTestCase {
    var sut:PortfolioViewController!
    var interactorMock:InteractorMock!
    var routerMock:RouterMock!
    var window:UIWindow!
    override func setUp() {
        super.setUp()
        interactorMock = InteractorMock()
        routerMock = RouterMock()
        self.sut = PortfolioViewController(interactor: interactorMock,
                                           router: routerMock)
        window = UIWindow()
        window.rootViewController = sut
        window.makeKeyAndVisible()
        sut.view.layoutSubviews()
    }
}
extension PortfolioViewControllerTests {
    class InteractorMock: PortfolioInteractorInput {
        func performFetchArt(request: Portfolio.FetchArt.Request) {}

        var numberOfArts_exp:XCTestExpectation?
        func numberOfArts() -> Int {
            numberOfArts_exp?.fulfill()
            return 1
        }

        var imageUrlForArtAtIndex_exp:XCTestExpectation?
        func imageUrlForArtAtIndex(_ index: Int) -> URL? {
            imageUrlForArtAtIndex_exp?.fulfill()
            return Seeds.Model.ArtSeed().imageUrl
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

    class RouterMock: PortfolioRouterInput {
        var dataStore: PortfolioDataStore?
    }
}

extension PortfolioViewControllerTests {
//    func test_updateViewModel_loading(){
//        // when
//        sut.viewModel = Portfolio.FetchArt.ViewModel(viewState: .loading,
//                                                          highlightedIndex:nil)
//    }
//
//    func test_updateViewModel_loaded(){
//        // given
//        let exp1 = XCTestExpectation(description: "CollectionView should ask for count")
//        let exp2 = XCTestExpectation(description: "CollectionView should ask for cells")
//        let viewModel = Portfolio.FetchArt.ViewModel(viewState: .loaded(true),
//                                                          highlightedIndex:nil)
//        // when
//        interactor.numberOfArts_exp = exp1
//        interactor.imageUrlForArtAtIndex_exp = exp2
//        sut.viewModel = viewModel
//        // then
//        wait(for: [exp1, exp2], timeout: 1)
//    }
//
//    func test_updateViewModel_error(){
//        // given
//        let viewModel = Portfolio.FetchArt.ViewModel(viewState: .error("Error"),
//                                                          highlightedIndex:nil)
//        // when
//        sut.viewModel = viewModel
//    }
//
//    func test_didHighlightItem_forwarded_interactor(){
//        // given
//        let row = 0
//        // when
//        sut.collectionView(sut.rootView.collectionView,
//                           didHighlightItemAt: IndexPath(row: row, section: 0))
//        // then
//        XCTAssert(interactor.setHighlightedIndex_value == row,
//                  "Highlighting a cell should update interactor")
//    }
//
//    func test_didUnhighlightItem_forwarded_interactor(){
//        // given
//        let row = 0
//        // when
//        sut.collectionView(sut.rootView.collectionView,
//                           didUnhighlightItemAt: IndexPath(row: row, section: 0))
//        // then
//        XCTAssert(interactor.setHighlightedIndex_value == nil,
//                  "Unhighlighting a cell should update interactor")
//    }
//
//    func test_didSelectItem_forwarded_interactor(){
//        // given
//        let row = 0
//        // when
//        sut.collectionView(sut.rootView.collectionView,
//                           didSelectItemAt: IndexPath(row: row, section: 0))
//        // then
//        XCTAssert(interactor.setSelectedIndex_value == row,
//                  "Selecting a cell should update interactor")
//    }
}
