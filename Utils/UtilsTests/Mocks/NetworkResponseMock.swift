
import Foundation
@testable import Utils

class NetworkResponseMock: NetworkResponse {
    
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?

    init(data: Data?,
         urlResponse: URLResponse?,
        error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self.error = error
    }
}
