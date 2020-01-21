import Foundation
import TimKit

public protocol Dependencies: TimKit.Dependencies {}

extension Dependencies {

//    static func resolve() -> APIService {
//        resolve(apiConfig: resolve())
//    }

    static func resolve() -> APIConfig {
        return try! APIConfig(
            scheme: "https",
            host: "www.rijksmuseum.nl",
            path: "/api/en",
            queryItems: [
                "key": "VV23OnI1",
                "format": "json"
            ]
        )
    }

    static func resolve() -> JSONDecoderService {
        return JSONDecoder()
    }
}
