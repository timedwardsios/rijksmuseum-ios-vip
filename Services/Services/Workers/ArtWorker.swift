
import Foundation
import Utils

public protocol ArtWorker {
    func fetchArt(completion: @escaping (Result<[Art], Error>)->Void)
}

class ArtWorkerDefault {
    let apiRequestFactory: APIRequestFactory
    let networkRequestFactory: NetworkRequestFactory
    let networkService: NetworkService
    let artFactory: ArtFactory
    init(apiRequestFactory: APIRequestFactory,
         networkRequestFactory: NetworkRequestFactory,
         networkService: NetworkService,
         artFactory: ArtFactory){
        self.apiRequestFactory = apiRequestFactory
        self.networkRequestFactory = networkRequestFactory
        self.networkService = networkService
        self.artFactory = artFactory
    }
}

extension ArtWorkerDefault: ArtWorker {
    func fetchArt(completion: @escaping (Result<[Art], Error>) -> Void) {
        let apiRequest = apiRequestFactory.createRequest(fromAPIEndpoint: .art)

        guard let networkRequest = try? networkRequestFactory.createRequest(fromAPIRequest: apiRequest) else {
            completion(.failure(LocalError.networkRequestCreationFailure))
            return
        }

        networkService.processRequest(networkRequest) { [weak self] (result) in
            guard let data = result.unwrap() else {
                completion(.failure(LocalError.networkServiceFailure))
                return
            }

            guard let arts = try? self?.artFactory.createArts(fromJSONData: data) else {
                completion(.failure(LocalError.networkServiceFailure))
                return
            }

            completion(.success(arts))
        }

    }
}

private extension ArtWorkerDefault {
    private enum LocalError: String, LocalizedError{
        case networkRequestCreationFailure
        case networkServiceFailure
        case artFactoryFailure
    }
}
