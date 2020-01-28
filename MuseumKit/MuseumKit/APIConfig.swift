import Foundation
import TimKit

struct APIConfigDefault: APIConfig {
    var scheme: URLScheme = .https

    var hostname = Hostname(rawValue: "www.rijksmuseum.nl")!

    var path = "/api/en"

    var queryItems = [
        "key": "VV23OnI1",
        "format": "json"
    ]
}
