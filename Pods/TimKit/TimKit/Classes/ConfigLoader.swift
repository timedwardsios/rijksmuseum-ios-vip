import Foundation

public enum ConfigLoaderError: LocalizedError {

    case badResourceURL
    case dataLoadFailure(Error)
    case decodeFailure(Error)
}

public protocol ConfigLoader {
    func getConfig<T: Decodable>(forBundle bundle: Bundle) throws -> T
}

class ConfigLoaderDefault {

    private let configFileName = "config.plist"

    let propertyListDecoderService: PropertyListDecoderService

    init(propertyListDecoderService: PropertyListDecoderService) {
        self.propertyListDecoderService = propertyListDecoderService
    }
}

extension ConfigLoaderDefault: ConfigLoader {

    func getConfig<T: Decodable>(forBundle bundle: Bundle) throws -> T {

        let configFileURL = try getConfigFileURL(forBundle: bundle)

        let data = try getDataAtURL(configFileURL)

        let config: T = try decodeConfigFromData(data)

        return config
    }
}

private extension ConfigLoaderDefault {

    func getConfigFileURL(forBundle bundle: Bundle) throws -> URL {

        guard let configURL = bundle.url(forResource: configFileName, withExtension: nil) else {
            throw ConfigLoaderError.badResourceURL
        }

        return configURL
    }

    func getDataAtURL(_ url: URL) throws -> Data {

        do {
            return try Data(contentsOf: url)
        } catch let error {
            throw ConfigLoaderError.dataLoadFailure(error)
        }
    }

    func decodeConfigFromData<T: Decodable>(_ data: Data) throws -> T {

        do {
            return try propertyListDecoderService.decode(T.self, from: data)
        } catch let error {
            throw ConfigLoaderError.decodeFailure(error)
        }
    }
}
