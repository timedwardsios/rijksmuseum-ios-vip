
import Foundation
import Utils
@testable import Service

class NetworkServiceMock: NetworkService {
    
    var processRequestReturnValue: Result<Data, Error>

    init(processRequestReturnValue: Result<Data, Error>) {
        self.processRequestReturnValue = processRequestReturnValue
    }

    var performRequestArgs = [NetworkRequest]()

    func processRequest(_ request: NetworkRequest, completion: (Result<Data, Error>) -> Void) {
        performRequestArgs.append(request)
        completion(processRequestReturnValue)
    }
}
