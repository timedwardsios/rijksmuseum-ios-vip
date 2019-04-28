
import XCTest
import TestTools
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
        sut.didBeginLoading()
        XCTAssertEqual([true], displaySpy.displayIsLoadingArgs)
    }

    func test_didFetchArts(){
        sut.didFetchArts([artMock])
        XCTAssertEqual([false], displaySpy.displayIsLoadingArgs)
        XCTAssertEqual([[artMock.imageURL]], displaySpy.displayImageURLsArgs)
    }

    func test_didFetchArts_empty(){
        sut.didFetchArts([ArtMock]())
        XCTAssertEqual([false], displaySpy.displayIsLoadingArgs)
        XCTAssertEqual([[URL]()], displaySpy.displayImageURLsArgs)
    }

    func test_didError(){
        let error = Seeds.error
        sut.didError(error)
        XCTAssertEqual([false], displaySpy.displayIsLoadingArgs)
        XCTAssertEqual([error.localizedDescription], displaySpy.displayErrorMessageArgs)
    }
}
