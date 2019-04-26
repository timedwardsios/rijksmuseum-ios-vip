
import Foundation
import UtilsTestTools
@testable import Services

struct APIConfigMock: APIConfig {
    var path = "/" + Seeds.string
    var queryItems = [Seeds.urlQueryItem]
    var scheme = "https"
    var host = Seeds.string
}
