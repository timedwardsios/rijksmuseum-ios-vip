//
//import XCTest
//@testable import App
//
//class PortfolioPresenterDefaultTests: XCTestCase {
//    var sut: PortfolioPresenterDefault!
//    var outputMock: OutputMock!
//    override func setUp() {
//        super.setUp()
//        outputMock = OutputMock()
//        sut = PortfolioPresenterDefault()
//        sut.output = outputMock
//    }
//
//}
//
//extension PortfolioPresenterDefaultTests {
//    class OutputMock: PortfolioPresenterDefaultOutput {
//        var presentFetchArt_loadingArgs = 0
//        var presentFetchArt_loadedArgs = 0
//        var presentFetchArt_loaded_value:[URL]?
//        var presentFetchArt_errorArgs = 0
//        var presentFetchArt_error_value:String?
//        func displayFetchArt(viewModel: Portfolio.FetchArt.ViewModel) {
//            switch viewModel.state {
//            case .loading:
//                presentFetchArt_loadingArgs += 1
//            case .loaded(let imageUrls):
//                presentFetchArt_loadedArgs += 1
//                presentFetchArt_loaded_value = imageUrls
//            case .error(let errorMessage):
//                presentFetchArt_errorArgs += 1
//                presentFetchArt_error_value = errorMessage
//            }
//        }
//    }
//}
//
//
//extension PortfolioPresenterDefaultTests {
//    func test_didFetchArt(){
//        // given
//        let response = Portfolio.FetchArt.Response(state: .loading)
//        // when
//        sut.presentFetchArt(response: response)
//    }
//
//    func test_didFetchArt_viewController_loading(){
//        // given
//        let response = Portfolio.FetchArt.Response(state: .loading)
//        // when
//        sut.presentFetchArt(response: response)
//        XCTAssert(outputMock.presentFetchArt_loadingArgs == 1)
//    }
//
//    func test_didFetchArt_viewController_loaded(){
//        let artSeed = Seeds.Model.ArtSeed()
//        let response = Portfolio.FetchArt.Response(state: .loaded([artSeed]))
//        sut.presentFetchArt(response: response)
//        XCTAssert(outputMock.presentFetchArt_loadedArgs == 1)
//    }
//
//    func test_didFetchArt_viewController_loaded_value(){
//        let artSeed = Seeds.Model.ArtSeed()
//        let response = Portfolio.FetchArt.Response(state: .loaded([artSeed]))
//        sut.presentFetchArt(response: response)
//        let firstValue = outputMock.presentFetchArt_loaded_value?.first
//        XCTAssert(firstValue == artSeed.imageUrl)
//    }
//
//    func test_didFetchArt_viewController_error(){
//        let errorSeed = Seeds.ErrorSeed.generic
//        let response = Portfolio.FetchArt.Response(state: .error(errorSeed))
//        sut.presentFetchArt(response: response)
//        XCTAssert(outputMock.presentFetchArt_errorArgs == 1)
//    }
//
//    func test_didFetchArt_viewController_error_value(){
//        let errorSeed = Seeds.ErrorSeed.generic
//        let response = Portfolio.FetchArt.Response(state: .error(errorSeed))
//        sut.presentFetchArt(response: response)
//        XCTAssert(outputMock.presentFetchArt_error_value == errorSeed.message)
//    }
//}
