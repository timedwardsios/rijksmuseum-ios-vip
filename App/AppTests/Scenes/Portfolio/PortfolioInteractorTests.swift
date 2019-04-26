
import XCTest
import UtilsTestTools
@testable import App

extension PortfolioResponse: Equatable {
    public static func == (lhs: PortfolioResponse, rhs: PortfolioResponse) -> Bool {
        switch (lhs, rhs) {
        case (.didBeginLoading, .didBeginLoading),
             (.didError, .didError):
            return true
        case (PortfolioResponse.didFetchArts(let leftArts), PortfolioResponse.didFetchArts(let rightArts)):
            if let leftArts = leftArts as? [ArtMock],
                let rightArts = rightArts as? [ArtMock],
                leftArts == rightArts {
                return true
            }
            return false
        default:
            return false
        }
    }
}

class PortfolioInteractorTests: XCTestCase {

    var sut: PortfolioInteractor!

    var presenter: PresenterSpy<PortfolioResponse>!
    var artWorker: ArtWorkerSpy!

    var artMock: ArtMock!

    override func setUp() {
        super.setUp()
        presenter = .init()
        artMock = .init()
        artWorker = .init(fetchArtResult: .success([artMock]))
        sut = .init(present: presenter.present,
                    artWorker: artWorker)
    }
}

extension PortfolioInteractorTests {

    func test_fetchArts() throws {
        sut.interact(request: .fetchArts)
        XCTAssertEqual(1, artWorker.fetchArtArgs)
        XCTAssertEqual(2, presenter.presentArgs.count)
        XCTAssertEqual(.didBeginLoading, presenter.presentArgs.first)
        XCTAssertEqual(PortfolioResponse.didFetchArts([artMock]), presenter.presentArgs.last)
    }

    func test_fetchArts_artWorkerError() throws {
        artWorker.fetchArtResult = .failure(Seeds.error)
        sut.interact(request: .fetchArts)
        XCTAssertEqual(2, presenter.presentArgs.count)
        XCTAssertEqual(.didBeginLoading, presenter.presentArgs.first)
        XCTAssertEqual(.didError(Seeds.error), presenter.presentArgs.last)
    }

    func test_selectArt() throws {
        sut.arts = [artMock]
        XCTAssertNil(sut.selectedArt)
        sut.interact(request: .selectArt(index: 0))
        XCTAssertNotNil(sut.selectedArt)
    }
}
