
import XCTest
import UtilsTestTools
@testable import App

class PortfolioPresenterTests: XCTestCase {

    var sut: PortfolioPresenter!

    var displaySpy: PortfolioDisplaySpy!

    var artMock: ArtMock!

    override func setUp() {
        super.setUp()
        artMock = .init()
        displaySpy = .init()
        sut = .init(display: displaySpy)
    }
}

extension PortfolioPresenterTests {

    func test_didBeginLoading(){
        sut.presentResponse(.didBeginLoading)
        XCTAssertEqual([.isLoading(true)], displaySpy.displayViewModelArgs)
    }

    func test_didFetchArts(){
        sut.presentResponse(.didFetchArts([artMock]))
        XCTAssertEqual([.isLoading(false), .imageUrls([artMock.imageUrl])], displaySpy.displayViewModelArgs)
    }

    func test_didFetchArts_empty(){
        sut.presentResponse(.didFetchArts([ArtMock]()))
        XCTAssertEqual([.isLoading(false), .imageUrls([URL]())], displaySpy.displayViewModelArgs)
    }

    func test_didError(){
        let error = Seeds.error
        sut.presentResponse(.didError(error))
        XCTAssertEqual([.isLoading(false), .errorAlertMessage(error.localizedDescription)], displaySpy.displayViewModelArgs)
    }
}
