import Foundation
import TimKit
import Combine

public let dependencies = Dependencies()

public struct Dependencies {

    private let _model = Model()
    public func resolve() -> Model { _model }

    public func resolve() -> ArtController {
        ArtControllerDefault(
            apiService: TimKit.dependencies.resolve(apiConfig: resolve()),
            model: resolve()
        )
    }

    func resolve() -> APIConfig { APIConfigDefault() }
}
