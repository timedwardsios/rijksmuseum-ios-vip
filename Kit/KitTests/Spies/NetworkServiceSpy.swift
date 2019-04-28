
import Foundation
import Utils
@testable import Kit

class NetworkServiceSpy: NetworkService {
    
    var processRequestResult: Result<Data, Error>

    init(processRequestResult: Result<Data, Error>) {
        self.processRequestResult = processRequestResult
    }

    var processRequestArgs = [NetworkRequest]()

    func processNetworkRequest(_ request: NetworkRequest, completion: (Result<Data, Error>) -> Void) {
        processRequestArgs.append(request)
        completion(processRequestResult)
    }
}
