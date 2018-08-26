
import Utils

public typealias ServiceDependencies =
    HasAPISession &
    HasAPIConfig &
    HasAPIService &
    HasArtService &
    HasArtDetailsService

public protocol HasAPISession{
    var apiSession:APISession{get}
}

public protocol HasAPIConfig{
    var apiConfig:APIConfig{get}
}

public protocol HasAPIService{
    var apiService:APIService{get}
}

public protocol HasArtService{
    var artService:ArtService{get}
}

public protocol HasArtDetailsService{
    var artDetailsService:ArtDetailsService{get}
}
