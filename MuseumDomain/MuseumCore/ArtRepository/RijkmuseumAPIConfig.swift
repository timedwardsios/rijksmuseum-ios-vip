import Foundation
import Utils
import RxSwift

struct RijkmuseumAPIConfig: APIConfig {
    let basePath = "https://www.rijksmuseum.nl/api/en"

    let queryItems: [URLQueryItem] = [
        .init(name: "key", value: "VV23OnI1"),
        .init(name: "format", value: "json"),
    ]
}
