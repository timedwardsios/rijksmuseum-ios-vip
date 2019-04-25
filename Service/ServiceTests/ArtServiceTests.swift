
import XCTest
import Utils
import TestingUtils
@testable import Service

class ArtServiceTests: XCTestCase {

    var sut: ArtServiceDefault!
    var networkRequest: NetworkRequestMock!
    var apiRequestFactory: APIRequestFactorySpy!
    var networkService: NetworkServiceSpy!
    var jsonDecoderService: JSONDecoderServiceSpy!

    override func setUp() {
        super.setUp()
        networkRequest = .init(url: Seeds.url,
                               method: .GET)
        apiRequestFactory = .init(createRequestResult: .success(networkRequest))
        networkService = .init(processRequestResult: .success(Seeds.data))
        jsonDecoderService = JSONDecoderServiceSpy(decodeResult: .success(String.self))
        sut = ArtServiceDefault.init(apiRequestFactory: apiRequestFactory,
                    networkService: networkService,
                    jsonDecoderService: jsonDecoderService)
    }
}

extension ArtServiceTests {
}
