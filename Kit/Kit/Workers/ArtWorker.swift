
import Foundation
import Utils

public protocol ArtWorker {
    func fetchArt(completion: @escaping (Result<[Art], Error>)->Void)
}

internal class ArtWorkerDefault {
    let apiRequestFactory: APIRequestFactory
    let networkRequestFactory: NetworkRequestFactory
    let networkService: NetworkService
    let artFactory: ArtsFactory
    init(apiRequestFactory: APIRequestFactory,
         networkRequestFactory: NetworkRequestFactory,
         networkService: NetworkService,
         artFactory: ArtsFactory){
        self.apiRequestFactory = apiRequestFactory
        self.networkRequestFactory = networkRequestFactory
        self.networkService = networkService
        self.artFactory = artFactory
    }
}

extension ArtWorkerDefault: ArtWorker {

    func fetchArt(completion: @escaping (Result<[Art], Error>) -> Void) {

        guard let networkRequest = createNetworkRequestResult().unwrapWithErrorHandler(completion) else {
            return
        }

        startFetchingWithNetworkRequest(networkRequest, completion: completion)
    }
}

private extension ArtWorkerDefault {

    func createNetworkRequestResult() -> Result<NetworkRequest, Error> {
        let artEndpoint = APIEndpoint.art

        let apiRequest = apiRequestFactory.apiRequest(fromAPIEndpoint: artEndpoint)

        return networkRequestFactory.networkRequest(fromAPIRequest: apiRequest)
    }

    func startFetchingWithNetworkRequest(_ networkRequest: NetworkRequest, completion:@escaping (Result<[Art], Error>)->Void) {

        networkService.processNetworkRequest(networkRequest) { [weak self] (result) in

            guard let data = result.unwrapWithErrorHandler(completion) else {
                return
            }

            guard let art = self?.artFactory.arts(fromJSONData: data).unwrapWithErrorHandler(completion) else {
                return
            }

            completion(.success(art))
        }
    }
}
