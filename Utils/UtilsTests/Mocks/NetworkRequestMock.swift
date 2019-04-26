
import Foundation
import UtilsTestTools
@testable import Utils

class NetworkRequestMock: NetworkRequest {
    var url = Seeds.url
    var method = NetworkMethod.GET
}
