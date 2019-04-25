
import Foundation
import Utils
@testable import Service

class NetworkServiceSpy: NetworkService {
    
    var processRequestResult: Result<Data, Error>

    init(processRequestResult: Result<Data, Error>) {
        self.processRequestResult = processRequestResult
    }

    var performRequestArgs = [NetworkRequest]()

    func processRequest(_ request: NetworkRequest, completion: (Result<Data, Error>) -> Void) {
        performRequestArgs.append(request)
        completion(processRequestResult)
    }
}
