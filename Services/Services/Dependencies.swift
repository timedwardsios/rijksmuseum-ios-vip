
import Utilities

public protocol HasApiService{
    var apiService:APIServiceInterface{get}
}

public protocol HasArtService{
    var artService:ArtServiceInterface{get}
}

public protocol HasArtDetailsService{
    var artDetailsService:ArtDetailsServiceInterface{get}
}
