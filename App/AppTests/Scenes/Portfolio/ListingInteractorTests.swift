
import XCTest
import UtilsTestTools
@testable import App

extension ListingResponse: Equatable {
    public static func == (lhs: ListingResponse, rhs: ListingResponse) -> Bool {
        switch (lhs, rhs) {
        case (.didLoadArt(let artLeft), .didLoadArt(let artRight)):
            return (artLeft as? ArtMock) == (artRight as? ArtMock)
        }
    }
}

class ListingInteractorTests: XCTestCase {

    var sut: ListingInteractor!

    var presenterSpy: PresenterSpy<ListingResponse>!

    var artMock: ArtMock!

    override func setUp() {
        super.setUp()
        presenterSpy = .init()
        artMock = .init()
        sut = .init(presentResponse: presenterSpy.presentResponse,
                    art: artMock)
    }
}

extension ListingInteractorTests {
    func test_loadArt() throws {
        sut.processRequest(request: .loadArt)
        XCTAssertEqual(1, presenterSpy.presentResponseArgs.count)
        XCTAssertEqual(.didLoadArt(artMock), presenterSpy.presentResponseArgs.last)
    }
}
