
import Foundation

enum ArtServiceError: String,LocalizedError{
    case json = "JSON decoding error"
}

public protocol ArtService {
    func fetchArt(completion: @escaping (Result<[Art], Error>)->Void)
}


