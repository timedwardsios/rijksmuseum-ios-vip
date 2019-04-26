
import XCTest
import UtilsTestTools
@testable import App

extension PortfolioViewModel: Equatable {
    public static func == (lhs: PortfolioViewModel, rhs: PortfolioViewModel) -> Bool {
        switch (lhs, rhs) {
        case (.isLoading(let isLoadingLeft), .isLoading(let isLoadingRight)):
            return isLoadingLeft == isLoadingRight
        case (.imageUrls(let imageUrlsLeft), .imageUrls(let imageUrlsRight)):
            return imageUrlsLeft == imageUrlsRight
        case (.errorAlertMessage(let messageLeft), .errorAlertMessage(let messageRight)):
            return messageLeft == messageRight
        default:
            return false
        }
    }
}

class PortfolioPresenterTests: XCTestCase {

    var sut: PortfolioPresenter!

    var displaySpy: DisplaySpy<PortfolioViewModel>!

    var artMock: ArtMock!

    override func setUp() {
        super.setUp()
        artMock = .init()
        displaySpy = .init()
        sut = .init(displayViewModel: displaySpy.displayViewModel)
    }
}

extension PortfolioPresenterTests {

    func test_didBeginLoading(){
        sut.presentResponse(response: .didBeginLoading)
        XCTAssertEqual(1, displaySpy.displayViewModelArgs.count)
        XCTAssertEqual(.isLoading(true), displaySpy.displayViewModelArgs.last)
    }

    func test_didFetchArts(){
        sut.presentResponse(response: .didFetchArts([artMock]))
        XCTAssertEqual(2, displaySpy.displayViewModelArgs.count)
        XCTAssertEqual(.isLoading(false), displaySpy.displayViewModelArgs.first)
        XCTAssertEqual(.imageUrls([artMock.imageUrl]), displaySpy.displayViewModelArgs.last)
    }

    func test_didFetchArts_empty(){
        sut.presentResponse(response: .didFetchArts([ArtMock]()))
        XCTAssertEqual(2, displaySpy.displayViewModelArgs.count)
        XCTAssertEqual(.isLoading(false), displaySpy.displayViewModelArgs.first)
        XCTAssertEqual(.imageUrls([URL]()), displaySpy.displayViewModelArgs.last)
    }

    func test_didFetchArts_error(){
        let error = Seeds.error
        sut.presentResponse(response: .didError(error))
        XCTAssertEqual(2, displaySpy.displayViewModelArgs.count)
        XCTAssertEqual(.isLoading(false), displaySpy.displayViewModelArgs.first)
        XCTAssertEqual(.errorAlertMessage(error.localizedDescription), displaySpy.displayViewModelArgs.last)
    }
}
