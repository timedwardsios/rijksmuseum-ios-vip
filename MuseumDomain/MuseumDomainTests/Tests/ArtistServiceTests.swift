@testable import MuseumDomain
import TestKit
import Utils
import XCTest

class ArtistServiceTests: XCTestCase {
    var sut: ArtistServiceDefault!

    var apiRequestFactorySpy: APIRequestFactorySpy!
    var apiServiceSpy: APIServiceSpy!
    var artistFactorySpy: ArtistFactorySpy!

    var artistMock: ArtistMock!

    override func setUp() {
        super.setUp()

        artistMock = ArtistMock()

        artistFactorySpy = ArtistFactorySpy(artistsResult: .success([artistMock]))
        apiServiceSpy = APIServiceSpy(performAPIRequestResult: .success(Seeds.data))
        apiRequestFactorySpy = APIRequestFactorySpy()
        sut = ArtistServiceDefault(
            apiRequestFactory: apiRequestFactorySpy,
            apiService: apiServiceSpy,
            artistFactory: artistFactorySpy
        )
    }
}

extension ArtistServiceTests {
    func test_fetchArtists_callback() {
        // given
        let exp = expectation(description: "Should callback")
        // when
        sut.fetchArtists(forSearchTerm: Seeds.string) { result in
            // then
            XCTAssertEqual(
                self.artistFactorySpy.artistsResult.unwrap(),
                result.unwrap() as? [ArtistMock]
            )
            exp.fulfill()
        }
        wait(for: exp)
    }

    func test_fetchArtists_apiRequestFactory() {
        // given
        let exp = expectation(description: "Should callback")
        let searchTerm = Seeds.string

        // when
        sut.fetchArtists(forSearchTerm: searchTerm) { _ in

            // then
            XCTAssertEqual(1, self.apiRequestFactorySpy.constructAPIRequestArgs.count)

            guard let lastRequest = self.apiRequestFactorySpy.constructAPIRequestArgs.last else {
                XCTFail("Should have request")
                return
            }

            guard case let .search(actualSearchTerm) = lastRequest else {
                XCTFail("Should have search operation")
                return
            }

            XCTAssertEqual(searchTerm, actualSearchTerm)

            exp.fulfill()
        }
        wait(for: exp)
    }

    func test_fetchArtists_apiService() {
        // given
        let exp = expectation(description: "Should callback")
        // when
        sut.fetchArtists(forSearchTerm: Seeds.string) { _ in

            // then
            XCTAssertEqual(1, self.apiServiceSpy.performAPIRequestArgs.count)

            let lastRequest = self.apiServiceSpy.performAPIRequestArgs.last as? APIRequestMock
            XCTAssertEqual(self.apiRequestFactorySpy.constructAPIRequestResult, lastRequest)

            exp.fulfill()
        }
        wait(for: exp)
    }

    func test_fetchArtists_artistFactory() {
        // given
        let exp = expectation(description: "Should callback")

        // when
        sut.fetchArtists(forSearchTerm: Seeds.string) { _ in

            // then
            XCTAssertEqual(1, self.artistFactorySpy.artistsArgs.count)

            let lastRequest = self.artistFactorySpy.artistsArgs.last
            XCTAssertEqual(self.apiServiceSpy.performAPIRequestResult.unwrap(), lastRequest)

            exp.fulfill()
        }
        wait(for: exp)
    }

    func test_fetchArtists_apiServiceFailure() {
        // given
        let exp = expectation(description: "Should callback")

        apiServiceSpy.performAPIRequestResult = .failure(.networkResponseInvalid(Seeds.error))
        // when
        sut.fetchArtists(forSearchTerm: Seeds.string) { result in

            // then
            XCTAssertNil(result.unwrap())

            exp.fulfill()
        }
        wait(for: exp)
    }

    func test_fetchArtists_artistFactoryFailure() {
        // given
        let exp = expectation(description: "Should callback")

        artistFactorySpy.artistsResult = .failure(Seeds.error)

        // when
        sut.fetchArtists(forSearchTerm: Seeds.string) { result in

            // then
            XCTAssertNil(result.unwrap())

            exp.fulfill()
        }
        wait(for: exp)
    }
}
