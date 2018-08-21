
import XCTest
@testable import Rijksmuseum

class PortfolioPresenterTests: XCTestCase {
    var sut: PortfolioPresenter!
    var viewControllerMock: ViewControllerMock!
    override func setUp() {
        super.setUp()
        viewControllerMock = ViewControllerMock()
        sut = PortfolioPresenter()
        sut.viewController = viewControllerMock
    }

}

extension PortfolioPresenterTests {
    class ViewControllerMock: PortfolioViewControllerInput {
        var displayFetchArt_loading_invocations = 0
        var displayFetchArt_loaded_invocations = 0
        var displayFetchArt_loaded_value:[URL]?
        var displayFetchArt_error_invocations = 0
        func displayFetchArt(viewModel: Portfolio.FetchArt.ViewModel) {
            switch viewModel.state {
            case .loading:
                displayFetchArt_loading_invocations += 1
            case .loaded(let imageUrls):
                displayFetchArt_loaded_invocations += 1
                displayFetchArt_loaded_value = imageUrls
            case .error(_):
                displayFetchArt_error_invocations += 1
            }
        }
    }
}


extension PortfolioPresenterTests {
    func test_presentFetchArt(){
        let response = Portfolio.FetchArt.Response(state: .loading)
        sut.presentFetchArt(response: response)
    }

    func test_presentFetchArt_viewController_loading(){
        let response = Portfolio.FetchArt.Response(state: .loading)
        sut.presentFetchArt(response: response)
        XCTAssert(viewControllerMock.displayFetchArt_loading_invocations == 1)
    }

    func test_presentFetchArt_viewController_loaded(){
        let artSeed = Seeds.Model.ArtSeed()
        let response = Portfolio.FetchArt.Response(state: .loaded([artSeed]))
        sut.presentFetchArt(response: response)
        XCTAssert(viewControllerMock.displayFetchArt_loaded_invocations == 1)
    }

    func test_presentFetchArt_viewController_loaded_value(){
        let artSeed = Seeds.Model.ArtSeed()
        let response = Portfolio.FetchArt.Response(state: .loaded([artSeed]))
        sut.presentFetchArt(response: response)
        XCTAssert(viewControllerMock.displayFetchArt_loaded_value?.count == 1)
        let firstValue = viewControllerMock.displayFetchArt_loaded_value?.first
        XCTAssert(firstValue == artSeed.imageUrl)
    }


//    func test_performFetchArt(){
//        // given
//        let request = Portfolio.FetchArt.Request()
//        // when
//        sut.performFetchArt(request: request)
//    }
//
//    func test_performFetchArt_presenter_loading(){
//        // given
//        let request = Portfolio.FetchArt.Request()
//        // when
//        sut.performFetchArt(request: request)
//        // then
//        XCTAssert(presenterMock.presentFetchArt_loading_invocations == 1)
//    }
//
//    func test_performFetchArt_worker(){
//        // given
//        let request = Portfolio.FetchArt.Request()
//        // when
//        sut.performFetchArt(request: request)
//        // then
//        XCTAssert(artWorkerMock.fetchArt_invocations == 1)
//    }
//
//    func test_performFetchArt_presenter_loaded(){
//        // given
//        let request = Portfolio.FetchArt.Request()
//        // when
//        sut.performFetchArt(request: request)
//        // then
//        XCTAssert(presenterMock.presentFetchArt_loaded_invocations == 1)
//    }
//
//    func test_performFetchArt_presenter_loaded_value(){
//        // given
//        let request = Portfolio.FetchArt.Request()
//        // when
//        sut.performFetchArt(request: request)
//        // then
//        let value = presenterMock.presentFetchArt_loaded_value?.first
//        let castValue = value as! Seeds.Model.ArtSeed
//        XCTAssert(castValue === artWorkerMock.artSeed.first)
//    }
//
//    func test_performFetchArt_presenter_error(){
//        // given
//        let request = Portfolio.FetchArt.Request()
//        artWorkerMock.active = false
//        // when
//        sut.performFetchArt(request: request)
//        // then
//        XCTAssert(presenterMock.presentFetchArt_error_invocations == 1)
//    }
//
//    func test_performFetchArt_presenter_error_value(){
//        // given
//        let request = Portfolio.FetchArt.Request()
//        artWorkerMock.active = false
//        // when
//        sut.performFetchArt(request: request)
//        // then
//        let value = presenterMock.presentFetchArt_error_value as! Seeds.ErrorSeed
//        XCTAssert(value === artWorkerMock.errorSeed)
//    }







//    func test_presentFetchArt_success(){
//        // when
//        sut.presentFetchArt(response: Portfolio.FetchArt.Response(state: .loaded(<#T##[Art]#>)))
//        sut.presentFetchArt(response: Portfolio.FetchArt.Response(result: .success([])))
//        // then
//        if case .loaded(let newData) = viewController.viewModel.viewState {
//            XCTAssert(newData == true,
//                      "New data from the interactor should be flagged in the ViewModel")
//        } else {
//            XCTFail("View model should reflect loaded state")
//        }
//    }
//
//    func test_presentFetchArt_failure(){
//        // when
//        let error = Seeds.ErrorSeed()
//        sut.presentFetchArt(response: Portfolio.FetchArt.Response(result: .failure(error)))
//        // then
//        guard case .error = viewController.viewModel.viewState else {
//            XCTFail("View model should reflect error state")
//            return
//        }
//    }
//    
//    func test_presentHighlightedIndex_none(){
//        // when
//        sut.presentHighlightedIndex(nil)
//        // then
//        XCTAssert(viewController.viewModel.highlightedIndex == nil,
//                  "No index in the interactor should be forwarded")
//    }
//
//    func test_presentHighlightedIndex_some(){
//        // when
//        sut.presentHighlightedIndex(0)
//        // then
//        XCTAssert(viewController.viewModel.highlightedIndex == 0,
//                  "Correct index in the interactor should be forwarded")
//    }
}
