
import Foundation
import Utils
@testable import Service

class NetworkServiceMock: NetworkService {
    
    var resultToReturn: Result<Data, Error>

    init(resultToReturn: Result<Data, Error>) {
        self.resultToReturn = resultToReturn
    }

    var performRequestArgs = [NetworkRequest]()

    func processRequest(_ request: NetworkRequest, completion: (Result<Data, Error>) -> Void) {
        performRequestArgs.append(request)
        completion(resultToReturn)
    }
}
