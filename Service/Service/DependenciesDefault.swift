
import Foundation

public class DependenciesDefault: Dependencies {

    public init(){}

    // MARK: - internal
    lazy var apiSession: APISession = {
        return URLSession.shared
    }()

    lazy var apiConfig: APIConfig = {
        return APIConfigDefault()
    }()

    lazy var apiService: APIService = {
        return APIServiceDefault(apiSession: self.apiSession,
                                 apiConfig: self.apiConfig)
    }()

    // MARK: - public
    public lazy var artService: ArtService = {
        return ArtServiceDefault(apiService: self.apiService)
    }()

    public lazy var artDetailsService: ArtDetailsService = {
        return ArtDetailsServiceDefault(apiService: self.apiService)
    }()
}
