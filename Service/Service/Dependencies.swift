
import Utils

public typealias ServiceDependencies =
    HasAPISession &
    HasAPIConfig &
    HasAPIService &
    HasArtService &
    HasArtDetailsService

public protocol HasAPISession{
    var apiSession:APISessionInterface{get}
}

public protocol HasAPIConfig{
    var apiConfig:APIConfigInterface{get}
}

public protocol HasAPIService{
    var apiService:APIServiceInterface{get}
}

public protocol HasArtService{
    var artService:ArtServiceInterface{get}
}

public protocol HasArtDetailsService{
    var artDetailsService:ArtDetailsServiceInterface{get}
}
