import Foundation
import TimKit

public class Dependencies {

    private let timKitDependencies = TimKit.Dependencies()

    public init() {}

    public var artistService: ArtistService {
        return ArtistServiceDefault(apiRequestFactory: apiRequestFactory,
                                    apiService: apiService,
                                    artistFactory: artistFactory)
    }

    private var apiService: APIService {
        return APIServiceDefault(urlRequestFactory: urlRequestFactory,
                                 networkSession: timKitDependencies.networkSession,
                                 networkResponseValidator: timKitDependencies.networkResponseValidator)
    }

    private var apiRequestFactory: APIRequestFactory {
        return APIRequestFactoryDefault(apiRequestTemplates: config.apiRequestTemplates,
                                        apiQueryStringKeys: config.apiQueryStringKeys)
    }

    private var urlRequestFactory: URLRequestFactory {
        return URLRequestFactoryDefault(baseAPIConfig: config.apiBaseConfig)
    }

    private var artistFactory: ArtistFactory {
        return ArtistFactoryDefault(jsonDecoderService: jsonDecoderService)
    }

    private var jsonDecoderService: JSONDecoderService {
        return JSONDecoder()
    }

    private lazy var config: Config = {
        return try! timKitDependencies.configLoader.getConfig(forBundle: bundle) as ConfigDecodable
    }()

    private lazy var bundle: Bundle = {
        return Bundle(for: type(of: self))
    }()
}
