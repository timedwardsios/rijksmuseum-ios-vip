
import Foundation
@testable import Service

class NetworkServiceMock: NetworkService {

    var result: Result<Data, Error>?

    var performRequest_invocations = [(URL, NetworkMethod)]()

    func performRequest(atUrl url: URL, usingMethod method: NetworkMethod, completion: @escaping (Result<Data, Error>) -> Void) {
        performRequest_invocations.append((url, method))
        if let result = result {
            completion(result)
        }
    }
}
