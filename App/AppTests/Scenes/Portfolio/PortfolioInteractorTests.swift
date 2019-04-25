
import XCTest
import Services
import UtilsTestTools
@testable import App

class PortfolioInteractorTests: XCTestCase {

    class PresenterSpy: PortfolioPresenting {
        var presentFetchArtsResponseArgs = [Portfolio.FetchArts.Response]()
        func presentFetchArtsResponse(_ response: Portfolio.FetchArts.Response) {
            presentFetchArtsResponseArgs.append(response)
        }
    }

    var sut: PortfolioInteractor!
    var presenter: PresenterSpy!
    var artWorker: ArtWorkerSpy!

    override func setUp() {
        super.setUp()
        presenter = .init()
        let artMock = ArtMock(id: Seeds.string, title: Seeds.string, artist: Seeds.string, imageUrl: Seeds.url)
        artWorker = .init(fetchArtResult: .success([artMock]))
        sut = .init(presenter: presenter, artWorker: artWorker)
    }
}

extension PortfolioInteractorTests {
    func test_processFetchArtsRequest(){
//        let response = Portfolio.FetchArts.Response(state: .loaded(<#T##T#>))
        sut.processFetchArtsRequest(.init())
        let actual = presenter.presentFetchArtsResponseArgs.last?.state
        XCTAssertEqual(<#T##expression1: Equatable##Equatable#>, presenter.presentFetchArtsResponseArgs.last?.)
    }
}
