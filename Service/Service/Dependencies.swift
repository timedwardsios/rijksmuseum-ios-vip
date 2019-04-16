
import Utils

typealias Dependencies =
    HasAPISession &
    HasAPIConfig &
    HasAPIService &
    HasArtService &
    HasArtDetailsService

// MARK: - internal
protocol HasAPISession{
    static var apiSession:APISession{get}
}

protocol HasAPIConfig{
    static var apiConfig:APIConfig{get}
}

protocol HasAPIService{
    static var apiService:APIService{get}
}

// MARK: - public
public protocol HasArtService{
    static var artService:ArtService{get}
}

public protocol HasArtDetailsService{
    static var artDetailsService:ArtDetailsService{get}
}
