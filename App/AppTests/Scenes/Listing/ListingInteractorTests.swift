
import XCTest
import TestTools
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
        sut.loadArt()
        XCTAssertEqual([artMock], presenterSpy.didLoadArtArgs as? [ArtMock])
    }
}
