
import Foundation
import Utils
@testable import Services

class NetworkServiceSpy: NetworkService {
    
    var processRequestResult: Result<Data, Error>

    init(processRequestResult: Result<Data, Error>) {
        self.processRequestResult = processRequestResult
    }

    var processRequestArgs = [NetworkRequest]()

    func processRequest(_ request: NetworkRequest, completion: (Result<Data, Error>) -> Void) {
        processRequestArgs.append(request)
        completion(processRequestResult)
    }
}
