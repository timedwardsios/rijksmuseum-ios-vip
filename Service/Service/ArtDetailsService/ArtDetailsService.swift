
import Foundation

public protocol ArtDetailsService {
    func fetchArt(completion: @escaping (Result<[Art], Error>)->Void)
}
