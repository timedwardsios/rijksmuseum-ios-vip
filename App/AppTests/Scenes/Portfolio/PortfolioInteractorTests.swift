
import XCTest
import TestTools
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

    func test_fetchArts() {
        sut.fetchArts()
        XCTAssertEqual(1, artWorker.fetchArtArgs)
        XCTAssertEqual(1, presenterSpy.didBeginLoadingArgs)
        XCTAssertEqual([[artMock]], presenterSpy.didFetchArtsArgs as? [[ArtMock]])
    }

    func test_fetchArts_artWorkerError() {
        let error = Seeds.error
        artWorker.fetchArtResult = .failure(error)
        sut.fetchArts()
        XCTAssertEqual(1, presenterSpy.didBeginLoadingArgs)
        XCTAssertEqual([error.localizedDescription], presenterSpy.didErrorArgs.compactMap({$0.localizedDescription}))
    }

    func test_selectArt() {
        XCTAssertNil(sut.selectedArt)
        sut.fetchArts()
        sut.selectArt(atIndex: 0)
        XCTAssertNotNil(sut.selectedArt)
    }
}
