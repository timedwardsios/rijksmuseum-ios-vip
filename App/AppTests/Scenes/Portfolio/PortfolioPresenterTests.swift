
import XCTest
@testable import App

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
    class ViewControllerMock: PortfolioViewControllerProtocol {
        var displayFetchArt_loading_invocations = 0
        var displayFetchArt_loaded_invocations = 0
        var displayFetchArt_loaded_value:[URL]?
        var displayFetchArt_error_invocations = 0
        var displayFetchArt_error_value:String?
        func displayFetchArt(viewModel: PortfolioScene.FetchArt.ViewModel) {
            switch viewModel.state {
            case .loading:
                displayFetchArt_loading_invocations += 1
            case .loaded(let imageUrls):
                displayFetchArt_loaded_invocations += 1
                displayFetchArt_loaded_value = imageUrls
            case .error(let errorMessage):
                displayFetchArt_error_invocations += 1
                displayFetchArt_error_value = errorMessage
            }
        }
    }
}


extension PortfolioPresenterTests {
    func test_didFetchArt(){
        // given
        let response = PortfolioScene.FetchArt.Response(state: .loading)
        // when
        sut.didFetchArt(response: response)
    }

    func test_didFetchArt_viewController_loading(){
        // given
        let response = PortfolioScene.FetchArt.Response(state: .loading)
        // when
        sut.didFetchArt(response: response)
        XCTAssert(viewControllerMock.displayFetchArt_loading_invocations == 1)
    }

    func test_didFetchArt_viewController_loaded(){
        let artSeed = Seeds.Model.ArtSeed()
        let response = PortfolioScene.FetchArt.Response(state: .loaded([artSeed]))
        sut.didFetchArt(response: response)
        XCTAssert(viewControllerMock.displayFetchArt_loaded_invocations == 1)
    }

    func test_didFetchArt_viewController_loaded_value(){
        let artSeed = Seeds.Model.ArtSeed()
        let response = PortfolioScene.FetchArt.Response(state: .loaded([artSeed]))
        sut.didFetchArt(response: response)
        XCTAssert(viewControllerMock.displayFetchArt_loaded_value?.count == 1)
        let firstValue = viewControllerMock.displayFetchArt_loaded_value?.first
        XCTAssert(firstValue == artSeed.imageUrl)
    }

    func test_didFetchArt_viewController_error(){
        let errorSeed = Seeds.ErrorSeed.generic
        let response = PortfolioScene.FetchArt.Response(state: .error(errorSeed))
        sut.didFetchArt(response: response)
        XCTAssert(viewControllerMock.displayFetchArt_error_invocations == 1)
    }

    func test_didFetchArt_viewController_error_value(){
        let errorSeed = Seeds.ErrorSeed.generic
        let response = PortfolioScene.FetchArt.Response(state: .error(errorSeed))
        sut.didFetchArt(response: response)
        XCTAssert(viewControllerMock.displayFetchArt_error_value == errorSeed.message)
    }
}
