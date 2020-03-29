import Foundation
@testable import MuseumDomain
import Utils

class APIServiceSpy: APIService {
    var performAPIRequestResult: Result<Data, APIServiceError>

    var performAPIRequestArgs = [APIRequest]()

    init(performAPIRequestResult: Result<Data, APIServiceError>) {
        self.performAPIRequestResult = performAPIRequestResult
    }

    func performAPIRequest(
        _ apiRequest: APIRequest,
        completion: @escaping (Result<Data, APIServiceError>) -> Void
    ) {
        performAPIRequestArgs.append(apiRequest)

        completion(performAPIRequestResult)
    }
}
