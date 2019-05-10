import Foundation
import TimKit
@testable import MuseumKit

class NetworkRequestFactorySpy: NetworkRequestFactory {

    var networkRequestResult: Result<NetworkRequest, Error>

    init(networkRequestResult: Result<NetworkRequest, Error>) {
        self.networkRequestResult = networkRequestResult
    }

    var networkRequestArgs = [APIRequest]()

    func networkRequest(fromAPIRequest apiRequest: APIRequest) -> Result<NetworkRequest, Error> {
        networkRequestArgs.append(apiRequest)
        return networkRequestResult
    }
}
