import Foundation
import TimKit

public enum ArtistServiceError: LocalizedError {

    case fetchFailure(Error)

    case artistCreationFailure(Error)
}

public protocol ArtistService {
    func fetchArtists(forSearchTerm searchTerm: String,
                      completion: @escaping (Result<[Artist], ArtistServiceError>) -> Void)
}

class ArtistServiceDefault {

    let apiRequestFactory: APIRequestFactory

    let apiService: APIService

    let artistFactory: ArtistFactory

    init(apiRequestFactory: APIRequestFactory,
         apiService: APIService,
         artistFactory: ArtistFactory) {
        self.apiRequestFactory = apiRequestFactory
        self.apiService = apiService
        self.artistFactory = artistFactory
    }
}

extension ArtistServiceDefault: ArtistService {

    func fetchArtists(forSearchTerm searchTerm: String,
                      completion: @escaping (Result<[Artist], ArtistServiceError>) -> Void) {

        let apiRequest = getAPIRequest(forSearchTerm: searchTerm)

        startFetchingWithAPIRequest(apiRequest, completion: completion)
    }
}

private extension ArtistServiceDefault {

    func getAPIRequest(forSearchTerm searchTerm: String) -> APIRequest {
        return apiRequestFactory.constructAPIRequest(fromOperation: .search(term: searchTerm))
    }

    func startFetchingWithAPIRequest(_ apiRequest: APIRequest,
                                     completion:@escaping (Result<[Artist], ArtistServiceError>) -> Void) {

        apiService.performAPIRequest(apiRequest, completion: {[weak self] (result) in

            self?.didFetchWithResult(result, completion: completion)
        })
    }

    func didFetchWithResult(_ result: Result<Data, APIServiceError>,
                            completion: (Result<[Artist], ArtistServiceError>) -> Void) {

        switch result {
        case .success(let data):

            createArtistsFromData(data, completion: completion)

        case .failure(let error):

            completion(.failure(.fetchFailure(error)))
        }
    }

    func createArtistsFromData(_ data: Data, completion: (Result<[Artist], ArtistServiceError>) -> Void) {

        do {
            let artistResult = try artistFactory.constructArtists(fromJSONData: data)

            completion(.success(artistResult))

        } catch let error {
            completion(.failure(.artistCreationFailure(error)))
        }
    }
}
