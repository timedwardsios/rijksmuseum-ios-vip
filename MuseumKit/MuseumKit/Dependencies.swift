import Foundation
import TimKit

public let dependencies = Dependencies()

public struct Dependencies {

    public func resolve() -> ArtController {
        ArtControllerDefault(apiService: TimKit.dependencies.resolve(apiConfig: resolve()), model: resolve())
    }

    private let _model = Model()
    func resolve() -> Model { _model }
}

private extension Dependencies {

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
}
