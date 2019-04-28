
import Foundation
import TestTools
import Utils
@testable import Services

struct NetworkRequestMock: NetworkRequest, Equatable {
    var url = Seeds.url
    var method = NetworkMethod.GET
}
