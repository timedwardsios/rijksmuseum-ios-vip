
import XCTest
import UtilsTestTools
@testable import App

class PortfolioInteractorTests: XCTestCase {

    var sut: PortfolioInteractor!

    var artWorker: ArtWorkerSpy!

    var presenterSpy: PortfolioPresenterSpy!

    var artMock: ArtMock!

    override func setUp() {
        super.setUp()
        artMock = .init()
        presenterSpy = .init()
        artWorker = .init(fetchArtResult: .success([artMock]))
        sut = .init(presenter: presenterSpy, artWorker: artWorker)
    }
}

extension PortfolioInteractorTests {

    func test_fetchArts() throws {
        sut.processRequest(.fetchArts)
        XCTAssertEqual(1, artWorker.fetchArtArgs)
        XCTAssertEqual([.didBeginLoading, .didFetchArts([artMock])], presenterSpy.presentResponseArgs)
    }

    func test_fetchArts_artWorkerError() throws {
        artWorker.fetchArtResult = .failure(Seeds.error)
        sut.processRequest(.fetchArts)
        XCTAssertEqual([.didBeginLoading, .didError(Seeds.error)], presenterSpy.presentResponseArgs)
    }

    func test_selectArt() throws {
        sut.arts = [artMock]
        XCTAssertNil(sut.selectedArt)
        sut.processRequest(.selectArt(index: 0))
        XCTAssertNotNil(sut.selectedArt)
    }
}
