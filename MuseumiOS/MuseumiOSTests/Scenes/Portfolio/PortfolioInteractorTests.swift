import XCTest
import TestKit
@testable import MuseumiOS

//class PortfolioInteractorTests: XCTestCase {
//
//    var sut: PortfolioInteractor!
//
//    var artService: ArtServiceSpy!
//
//    var presenterSpy: PortfolioPresenterSpy!
//
//    var artMock: ArtMock!
//
//    override func setUp() {
//        super.setUp()
//        artMock = .init()
//        presenterSpy = .init()
//        artService = .init(fetchArtResult: .success([artMock]))
//        sut = .init(presenter: presenterSpy, artService: artService)
//    }
//}
//
//extension PortfolioInteractorTests {
//
//    func test_fetchArts() {
//        sut.fetchArts()
//        XCTAssertEqual(1, artService.fetchArtArgs)
//        XCTAssertEqual(1, presenterSpy.didBeginLoadingArgs)
//        XCTAssertEqual([[artMock]], presenterSpy.didFetchArtsArgs as? [[ArtMock]])
//    }
//
//    func test_fetchArts_artServiceError() {
//        let error = Seeds.error
//        artService.fetchArtResult = .failure(error)
//        sut.fetchArts()
//        XCTAssertEqual(1, presenterSpy.didBeginLoadingArgs)
//        XCTAssertEqual([error.localizedDescription], presenterSpy.didErrorArgs.compactMap({$0.localizedDescription}))
//    }
//
//    func test_selectArt() {
//        XCTAssertNil(sut.selectedArt)
//        sut.fetchArts()
//        sut.selectArt(atIndex: 0)
//        XCTAssertNotNil(sut.selectedArt)
//    }
//}
