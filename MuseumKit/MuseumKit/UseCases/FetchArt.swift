import Foundation
import TimKit

struct FetchArtAPIRequest: APIRequest {

    var path = "/collection"

    var queryItems = [
        "ps": "100",
        "imgonly": "true",
        "s": "relevance"
    ]

    var method = HTTPMethod.GET
}

public enum ArtServiceError: LocalizedError {

    case fetchFailure(Error)

    case artistCreationFailure(Error)
}

public protocol ArtService {
    func fetchArt(completion: @escaping (Result<[Art], ArtServiceError>) -> Void)
}

class ArtServiceDefault {

    let apiService: APIService

    init(apiService: APIService) {
        self.apiService = apiService
    }
}

extension ArtServiceDefault: ArtService {

    func fetchArt(completion: @escaping (Result<[Art], ArtServiceError>) -> Void) {

        apiService.performAPIRequest(FetchArtAPIRequest(), completion: {[weak self] (result) in

            self?.didFetchWithResult(result, completion: completion)
        })
    }
}

private extension ArtServiceDefault {


    func didFetchWithResult(_ result: Result<Data, APIServiceError>,
                            completion: (Result<[Art], ArtServiceError>) -> Void) {

        switch result {
        case .success(let data):

            createArtistsFromData(data, completion: completion)

        case .failure(let error):

            completion(.failure(.fetchFailure(error)))
        }
    }

    func createArtistsFromData(_ data: Data, completion: (Result<[Art], ArtServiceError>) -> Void) {

        do {
            let arts: [Art] = try .init(fromJSONData: data)

            completion(.success(arts))

        } catch let error {
            completion(.failure(.artistCreationFailure(error)))
        }
    }
}
