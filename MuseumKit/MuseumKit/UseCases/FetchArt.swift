import Foundation
import TimKit

public protocol Art {

    var identifier: String { get }

    var title: String { get }

    var artist: String { get }

    var imageURL: URL { get }
}

public enum ArtServiceError: LocalizedError {
    case requestError(Error), fetchError(Error), decodingError(Error)
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

        do {
            let fetchArtAPIRequest = try APIRequest(
                path: "/collection",
                queryItems: [
                    "ps": "100",
                    "imgonly": "true",
                    "s": "relevance"
                ],
                method: APIMethod.GET
            )

            apiService.performAPIRequest(fetchArtAPIRequest) { [weak self] (result) in
                self?.didFetchWithResult(result, completion: completion)
            }
        } catch let error {
            completion(.failure(.requestError(error)))
            return
        }
    }
}

private extension ArtServiceDefault {


    func didFetchWithResult(_ result: Result<Data, APIServiceError>,
                            completion: (Result<[Art], ArtServiceError>) -> Void) {

        switch result {
        case .success(let data):

            createArtistsFromData(data, completion: completion)

        case .failure(let error):

            completion(.failure(.fetchError(error)))
        }
    }

    func createArtistsFromData(_ data: Data, completion: (Result<[Art], ArtServiceError>) -> Void) {

        do {
            let arts: [Art] = try .init(fromJSONData: data)

            completion(.success(arts))

        } catch let error {
            completion(.failure(.decodingError(error)))
        }
    }
}
