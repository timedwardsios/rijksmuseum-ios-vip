import Foundation

public class Dependencies {
    public init() {}

    public var networkService: NetworkService {
        return NetworkServiceDefault(networkSession: networkSession,
                                     networkRawResponseValidator: networkRawResponseValidator)
    }

    public var configLoader: ConfigLoader {
        return ConfigLoaderDefault(propertyListDecoder: propertyListDecoder)
    }

    private var propertyListDecoder: PropertyListDecoder {
        return Foundation.PropertyListDecoder()
    }

    private var networkSession: NetworkSession {
        return URLSession.shared
    }

    private var networkRawResponseValidator: NetworkRawResponseValidator {
        return NetworkRawResponseValidatorDefault()
    }
}
