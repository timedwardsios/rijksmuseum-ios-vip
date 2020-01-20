import Foundation
import TimKit

public func resolve() -> ArtService {
    return ArtServiceDefault(apiService: resolve(apiConfig: APIConfigDefault()))
}

private func resolve() -> APIConfig {
    return APIConfigDefault()
}

internal func resolve() -> JSONDecoderService {
    return JSONDecoder()
}
