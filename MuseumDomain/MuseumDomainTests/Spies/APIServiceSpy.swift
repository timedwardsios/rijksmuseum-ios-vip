import Foundation
import Utils
@testable import MuseumDomain

class APIServiceSpy: APIService {

    var performAPIRequestResult: Result<Data, APIServiceError>

    init(performAPIRequestResult: Result<Data, APIServiceError>) {
        self.performAPIRequestResult = performAPIRequestResult
    }

    var performAPIRequestArgs = [APIRequest]()

    func performAPIRequest(_ apiRequest: APIRequest, completion: @escaping (Result<Data, APIServiceError>) -> Void) {
        performAPIRequestArgs.append(apiRequest)

        completion(performAPIRequestResult)
    }
}
