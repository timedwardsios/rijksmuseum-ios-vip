
import Foundation
import TestTools
@testable import Utils

struct NetworkRequestMock: NetworkRequest {
    var url = Seeds.url
    var method = NetworkMethod.GET
}
