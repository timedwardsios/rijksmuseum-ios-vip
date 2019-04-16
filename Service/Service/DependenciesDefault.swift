
import Foundation

public enum DependenciesDefault: Dependencies {
    // MARK: - internal
    static var apiSession: APISession = {
        return URLSession.shared
    }()

    static var apiConfig: APIConfig = {
        return APIConfigDefault()
    }()

    static var apiService: APIService = {
        return APIServiceDefault(apiSession: DependenciesDefault.apiSession,
                                 apiConfig: DependenciesDefault.apiConfig)
    }()

    // MARK: - public
    public static var artService: ArtService = {
        return ArtServiceDefault(apiService: DependenciesDefault.apiService)
    }()

    public static var artDetailsService: ArtDetailsService = {
        return ArtDetailsServiceDefault()
    }()
}
