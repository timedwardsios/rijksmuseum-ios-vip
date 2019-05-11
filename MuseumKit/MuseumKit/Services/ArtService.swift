import Foundation
import TimKit

public protocol ArtService {
    func fetchArt(completion: @escaping (Result<[Art], Error>) -> Void)
}

internal class ArtServiceDefault {
    let apiRequestConfig: APIRequestConfig
    let networkRequestFactory: NetworkRequestFactory
    let networkService: NetworkService
    let artFactory: ArtsFactory
    init(apiRequestConfig: APIRequestConfig,
         networkRequestFactory: NetworkRequestFactory,
         networkService: NetworkService,
         artFactory: ArtsFactory) {
        self.apiRequestConfig = apiRequestConfig
        self.networkRequestFactory = networkRequestFactory
        self.networkService = networkService
        self.artFactory = artFactory
    }
}

extension ArtServiceDefault: ArtService {

    func fetchArt(completion: @escaping (Result<[Art], Error>) -> Void) {

        guard let networkRequest = createNetworkRequestResult().unwrapWithErrorHandler(completion) else {
            return
        }

        startFetchingWithNetworkRequest(networkRequest, completion: completion)
    }
}

private extension ArtServiceDefault {

    func createNetworkRequestResult() -> Result<NetworkRequest, Error> {

        return networkRequestFactory.networkRequest(fromAPIRequest: apiRequestConfig.collection)
    }

    func startFetchingWithNetworkRequest(_ networkRequest: NetworkRequest,
                                         completion:@escaping (Result<[Art], Error>) -> Void) {

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
