
import XCTest
import UtilsTestTools
@testable import App

extension PortfolioResponse: Equatable {
    public static func == (lhs: PortfolioResponse, rhs: PortfolioResponse) -> Bool {
        switch (lhs, rhs) {
        case (.didBeginLoading, .didBeginLoading):
            return true
        case (PortfolioResponse.didFetchArts(let artsLeft), PortfolioResponse.didFetchArts(let artsRight)):
            if let artsLeft = artsLeft as? [ArtMock],
                let artsRight = artsRight as? [ArtMock],
                artsLeft == artsRight {
                return true
            }
            return false
        case (.didError, .didError):
            return true
        default:
            return false
        }
    }
}

class PortfolioInteractorTests: XCTestCase {

    var sut: PortfolioInteractor!

    var presenterSpy: PresenterSpy<PortfolioResponse>!
    var artWorker: ArtWorkerSpy!

    var artMock: ArtMock!

    override func setUp() {
        super.setUp()
        presenterSpy = .init()
        artMock = .init()
        artWorker = .init(fetchArtResult: .success([artMock]))
        sut = .init(presentResponse: presenterSpy.presentResponse,
                    artWorker: artWorker)
    }
}

extension PortfolioInteractorTests {

    func test_fetchArts() throws {
        sut.processRequest(request: .fetchArts)
        XCTAssertEqual(1, artWorker.fetchArtArgs)
        XCTAssertEqual(2, presenterSpy.presentResponseArgs.count)
        XCTAssertEqual(.didBeginLoading, presenterSpy.presentResponseArgs.first)
        XCTAssertEqual(PortfolioResponse.didFetchArts([artMock]), presenterSpy.presentResponseArgs.last)
    }

    func test_fetchArts_artWorkerError() throws {
        artWorker.fetchArtResult = .failure(Seeds.error)
        sut.processRequest(request: .fetchArts)
        XCTAssertEqual(2, presenterSpy.presentResponseArgs.count)
        XCTAssertEqual(.didBeginLoading, presenterSpy.presentResponseArgs.first)
        XCTAssertEqual(.didError(Seeds.error), presenterSpy.presentResponseArgs.last)
    }

    func test_selectArt() throws {
        sut.arts = [artMock]
        XCTAssertNil(sut.selectedArt)
        sut.processRequest(request: .selectArt(index: 0))
        XCTAssertNotNil(sut.selectedArt)
    }
}
