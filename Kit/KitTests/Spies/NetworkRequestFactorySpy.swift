import Foundation
import Utils
@testable import Kit

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
