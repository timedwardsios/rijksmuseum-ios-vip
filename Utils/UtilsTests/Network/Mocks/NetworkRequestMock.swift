
import Foundation
@testable import Utils

class NetworkRequestMock: NetworkRequest {
    var url: URL
    var method: NetworkMethod

    init(url: URL,
         method: NetworkMethod) {
        self.url = url
        self.method = method
    }
}
