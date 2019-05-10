import Foundation
import TestTools
@testable import TimKit

struct NetworkRequestMock: NetworkRequest {
    var url = Seeds.url
    var method = NetworkMethod.GET
}
