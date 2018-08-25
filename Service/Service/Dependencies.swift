
import Utils

public typealias ServiceDependencies =
    HasAPISession &
    HasAPIConfig &
    HasAPIService &
    HasArtService &
    HasArtDetailsService

public protocol HasAPISession{
    var apiSession:APISessionProtocol{get}
}

public protocol HasAPIConfig{
    var apiConfig:APIConfigProtocol{get}
}

public protocol HasAPIService{
    var apiService:APIServiceProtocol{get}
}

public protocol HasArtService{
    var artService:ArtServiceProtocol{get}
}

public protocol HasArtDetailsService{
    var artDetailsService:ArtDetailsServiceProtocol{get}
}
