import Foundation
import TimKit

public class Dependencies {

    private let timKitDependencies = TimKit.Dependencies()

    public init() {}

    public var artService: ArtService {
        return ArtServiceDefault(apiService: apiService,
                                 artFactory: artFactory)
    }

    private var apiService: APIService {
        return APIServiceDefault(urlRequestFactory: urlRequestFactory,
                                 networkSession: timKitDependencies.networkSession,
                                 networkResponseValidator: timKitDependencies.networkResponseValidator)
    }

    private var urlRequestFactory: URLRequestFactory {
        return URLRequestFactoryDefault(apiConfig: APIConfigDefault())
    }

    private var artFactory: ArtFactory {
        return ArtFactoryDefault(jsonDecoderService: jsonDecoderService)
    }

    private var jsonDecoderService: JSONDecoderService {
        return JSONDecoder()
    }

    private lazy var bundle: Bundle = {
        return Bundle(for: type(of: self))
    }()
}
