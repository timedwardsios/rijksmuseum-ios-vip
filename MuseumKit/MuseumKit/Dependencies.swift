import Foundation
import TimKit

public class Dependencies {
    private let timKitDependencies = TimKit.Dependencies()

    public init() {}

    public var artService: ArtService {
        return ArtServiceDefault(apiRequestConfig: config.apiRequestConfig,
                                 networkRequestFactory: networkRequestFactory,
                                 networkService: timKitDependencies.networkService,
                                 artFactory: artsFactory)
    }

    private var networkRequestFactory: NetworkRequestFactory {
        return NetworkRequestFactoryDefault(baseAPIConfig: config.apiBaseConfig)
    }

    private var artsFactory: ArtsFactory {
        return ArtsFactoryDefault(jsonDecoderService: jsonDecoderService)
    }

    private var jsonDecoderService: JSONDecoderService {
        return JSONDecoder()
    }

    private lazy var bundle: Bundle = {
        return Bundle(for: type(of: self))
    }()

    private lazy var config: Config = {
        return try! timKitDependencies.configLoader.getConfig(forBundle: bundle)
    }()
}
