
import Foundation
@testable import Service

class APIServiceMock: APIService {

    var resultToReturn: Result<Data, Error>

    init(resultToReturn: Result<Data, Error>) {
        self.resultToReturn = resultToReturn
    }

    var performRequestArgs = [APIRequest]()

    func performRequest(request: APIRequest,
                        completion: @escaping (Result<Data, Error>) -> Void) {
        performRequestArgs.append(request)
        completion(resultToReturn)
    }
}
