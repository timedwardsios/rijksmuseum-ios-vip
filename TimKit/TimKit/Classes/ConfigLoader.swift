import Foundation

public enum ConfigLoaderError: String, LocalizedError {
    case badResourceURL = "Failed to create resource URL from bundle"
    case dataLoadFailure = "Failed to load config data"
    case decodeFailure = "Failed to decode property list data"
}

public protocol ConfigLoader {
    func getConfig<T: Decodable>(forBundle bundle: Bundle) throws -> T
}

class ConfigLoaderDefault {

    private let configFileName = "config.plist"

    let propertyListDecoder: PropertyListDecoder

    init(propertyListDecoder: PropertyListDecoder) {
        self.propertyListDecoder = propertyListDecoder
    }
}

extension ConfigLoaderDefault: ConfigLoader {

    func getConfig<T: Decodable>(forBundle bundle: Bundle) throws -> T {

        guard let configURL = bundle.url(forResource: configFileName, withExtension: nil) else {
            throw ConfigLoaderError.badResourceURL
        }

        guard let data = try? Data(contentsOf: configURL) else {
            throw ConfigLoaderError.dataLoadFailure
        }

        guard let config = try? propertyListDecoder.decode(T.self, from: data) else {
            throw ConfigLoaderError.decodeFailure
        }
        return config
    }
}
