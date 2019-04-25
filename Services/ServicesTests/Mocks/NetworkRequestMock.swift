
import Foundation
import Utils
@testable import Services

class NetworkRequestMock: NetworkRequest {

    var url: URL
    var method: NetworkMethod
    
    init(url: URL,
         method: NetworkMethod) {
        self.url = url
        self.method = method
    }
}
