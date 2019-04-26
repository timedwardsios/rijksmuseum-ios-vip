
import XCTest
import UtilsTestTools
@testable import App

extension ListingViewModel: Equatable {
    public static func == (lhs: ListingViewModel, rhs: ListingViewModel) -> Bool {
        switch (lhs, rhs) {
        case (.imageUrl(let urlLeft), .imageUrl(let urlRight)):
            return urlLeft == urlRight
        }
    }
}

class ListingPresenterTests: XCTestCase {

    var sut: ListingPresenter!

    var displaySpy: DisplaySpy<ListingViewModel>!

    var artMock: ArtMock!

    override func setUp() {
        super.setUp()
        artMock = .init()
        displaySpy = .init()
        sut = .init(displayViewModel: displaySpy.displayViewModel)
    }
}

extension ListingPresenterTests {

    func test_didLoadArt(){
        sut.presentResponse(response: .didLoadArt(artMock))
        XCTAssertEqual(1, displaySpy.displayViewModelArgs.count)
        XCTAssertEqual(.imageUrl(artMock.imageUrl), displaySpy.displayViewModelArgs.last)
    }
}
