import Foundation
import TimKit

public func resolve() -> APIService {
    resolve(apiConfig: resolve())
}


private let model = Model()
public func resolve() -> Model {
    return model
}

func resolve() -> APIConfig {
    try! APIConfig(
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
    JSONDecoder()
}
