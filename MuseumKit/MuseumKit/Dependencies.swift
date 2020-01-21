import Foundation
import TimKit

public func resolve() -> ArtService {
    return ArtServiceDefault(apiService: resolve(apiConfig: resolve()))
}

private func resolve() -> APIConfig {
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

func resolve() -> JSONDecoderService {
    return JSONDecoder()
}
