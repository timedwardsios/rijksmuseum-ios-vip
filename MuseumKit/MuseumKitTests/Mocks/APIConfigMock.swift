import Foundation
import TestTools
@testable import MuseumKit

struct APIConfigMock: APIConfig {
    var path = "/" + Seeds.string
    var queryItems = [Seeds.urlQueryItem]
    var scheme = "https"
    var host = Seeds.string
}
