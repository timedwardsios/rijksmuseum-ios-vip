import Foundation

public protocol DependencyContainer {
    func resolve() -> NetworkService
    func resolve() -> ConfigService
}

public class Dependencies {
    public init() {}
}

extension Dependencies: DependencyContainer {
    public func resolve() -> NetworkService {
        return NetworkServiceDefault(networkSession: resolve(),
                                     networkRawResponseValidator: resolve())
    }

    public func resolve() -> ConfigService {
        return ConfigServiceDefault(fileManager: resolve(),
                                    propertyListDecoderService: resolve())
    }
}

private extension Dependencies {
    func resolve() -> FileManager {
        return FileManager.default
    }

    func resolve() -> PropertyListDecoder {
        return PropertyListDecoder()
    }

    func resolve() -> NetworkSession {
        return URLSession.shared
    }

    func resolve() -> NetworkRawResponseValidatorDefault {
        return NetworkRawResponseValidatorDefault()
    }
}
