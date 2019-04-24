
import Foundation
@testable import Utils

class NetworkServiceMock: NetworkService {
    var result: Result<Data, Error>?
    var response: NetworkResponse?

    var performRequest_invocations = [NetworkRequest]()

    func processRequest(_ request: NetworkRequest, completion: @escaping (NetworkResponse) -> Void) {
        performRequest_invocations.append(request)
        if let response = response {
            completion(response)
        }
    }
}
