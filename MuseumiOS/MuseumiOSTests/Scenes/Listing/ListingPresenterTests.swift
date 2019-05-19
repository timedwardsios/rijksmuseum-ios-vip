import XCTest
import TimTestTools
@testable import App

class ListingPresenterTests: XCTestCase {

    var sut: ListingPresenter!

    var displaySpy: ListingDisplaySpy!

    var artMock: ArtMock!

    override func setUp() {
        super.setUp()
        artMock = .init()
        displaySpy = .init()
        sut = .init(display: displaySpy)
    }
}

extension ListingPresenterTests {

    func test_didLoadArt() {
        sut.didLoadArt(artMock)
        XCTAssertEqual([artMock.imageURL], displaySpy.displayImageURLArgs)
    }
}
