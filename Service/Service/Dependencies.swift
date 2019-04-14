
import Utils

typealias Dependencies =
    HasAPISession &
    HasAPIConfig &
    HasAPIService &
    HasArtService &
    HasArtDetailsService

// MARK: - internal
protocol HasAPISession{
    var apiSession:APISession{get}
}

protocol HasAPIConfig{
    var apiConfig:APIConfig{get}
}

protocol HasAPIService{
    var apiService:APIService{get}
}

// MARK: - public
public protocol HasArtService{
    var artService:ArtService{get}
}

public protocol HasArtDetailsService{
    var artDetailsService:ArtDetailsService{get}
}
