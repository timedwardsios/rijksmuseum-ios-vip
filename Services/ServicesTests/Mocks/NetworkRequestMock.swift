
import Foundation
import UtilsTestTools
import Utils
@testable import Services

class NetworkRequestMock: NetworkRequest {
    var url = Seeds.url
    var method = NetworkMethod.GET
}
