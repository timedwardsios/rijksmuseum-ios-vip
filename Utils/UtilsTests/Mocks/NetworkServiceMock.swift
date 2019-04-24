
import Foundation
@testable import Utils

class NetworkServiceMock: NetworkService {
    var result: Result<Data, Error>?
    var response: NetworkResponseMock?

    var performRequest_invocations = [NetworkRequest]()

    func processRequest(_ request: NetworkRequest, completion: (Result<Data, Error>) -> Void) {
        performRequest_invocations.append(request)
        if let result = result {
            completion(result)
        }
    }
}
