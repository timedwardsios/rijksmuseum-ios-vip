
import XCTest
import UtilsTestTools
@testable import App

class ListingInteractorTests: XCTestCase {

    var sut: ListingInteractor!

    var presenterSpy: ListingPresenterSpy!

    var artMock: ArtMock!

    override func setUp() {
        super.setUp()
        presenterSpy = .init()
        artMock = .init()
        sut = .init(presenter: presenterSpy, art: artMock)
    }
}

extension ListingInteractorTests {
    
    func test_loadArt() throws {
        sut.processRequest(.loadArt)
        XCTAssertEqual([.didLoadArt(artMock)], presenterSpy.presentResponseArgs)
    }
}
