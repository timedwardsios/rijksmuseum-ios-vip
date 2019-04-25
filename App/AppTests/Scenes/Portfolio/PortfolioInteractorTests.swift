
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

        presenterSpy = .init()
        artWorker = .init(fetchArtResult: .success([Seeds]))
        outputMock = OutputMock()
        artServiceMock = ArtServiceSpy()
        sut = PortfolioInteractor(output: outputMock,
                                  artService: artServiceMock)
    }
}

extension PortfolioInteractorTests {



}
