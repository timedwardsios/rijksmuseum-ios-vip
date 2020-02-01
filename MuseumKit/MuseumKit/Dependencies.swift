import Foundation
import TimKit
import Combine

public let dependencies = Dependencies()

public struct Dependencies {
    private let state = State()
}

public extension Dependencies {
    func resolve() -> ArtInteractor {
        ArtInteractorDefault(museumWebService: resolve(), state: resolve())
    }
}

private extension Dependencies {

    func resolve() -> State { state }

    func resolve() -> MuseumWebService {
        MuseumWebServiceDefault(config: resolve(), urlSession: resolve(), jsonDecoder: resolve())
    }

    func resolve() -> WebServiceConfig { MuseumAPIConfig() }


    func resolve() -> URLSession { Foundation.URLSession.shared }
    func resolve() -> JSONDecoder { Foundation.JSONDecoder() }
}
