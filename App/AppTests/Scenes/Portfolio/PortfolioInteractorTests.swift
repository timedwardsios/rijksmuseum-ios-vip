
import XCTest
import Services
import UtilsTestTools
@testable import App

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

    func test_fetchArts_presenter() throws {
        sut.interact(request: .fetchArts)

        XCTAssertEqual(1, artWorker.fetchArtArgs)

        if case .didBeginLoading? = presenter.presentArgs.first {} else {
            XCTFail()
        }

        if case .didFetchArts(let art)? = presenter.presentArgs.last {
            XCTAssertEqual(artMock.id, art.first?.id)
        } else {
            XCTFail()
        }
    }

    func test_fetchArts_artWorkerError() throws {
        artWorker.fetchArtResult = .failure(Seeds.error)

        sut.interact(request: .fetchArts)

        if case .didBeginLoading? = presenter.presentArgs.first {} else {
            XCTFail()
        }

        if case .didError? = presenter.presentArgs.last {} else {
            XCTFail()
        }
    }

    func test_selectArt_artWorkerError() throws {
        sut.arts = [artMock]
        XCTAssertNil(sut.selectedArt)
        sut.interact(request: .selectArt(index: 0))
        XCTAssertNotNil(sut.selectedArt)
    }
}
