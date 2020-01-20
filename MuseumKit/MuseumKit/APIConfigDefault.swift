import Foundation
import TimKit

struct APIConfigDefault: APIConfig {

    var scheme = "https"

    var host = "www.rijksmuseum.nl"

    var path = "/api/en"

    var queryItems = [
        "key": "VV23OnI1",
        "format": "json"
    ]
}
