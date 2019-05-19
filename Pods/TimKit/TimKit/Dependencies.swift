import Foundation

public class Dependencies {

    public init() {}

    public var configLoader: ConfigLoader {
        return ConfigLoaderDefault(propertyListDecoderService: propertyListDecoderService)
    }

    public var networkSession: NetworkSession {
        return URLSession.shared
    }

    public var networkResponseValidator: NetworkResponseValidator {
        return NetworkResponseValidatorDefault()
    }

    private var propertyListDecoderService: PropertyListDecoder {
        return PropertyListDecoder()
    }
}
