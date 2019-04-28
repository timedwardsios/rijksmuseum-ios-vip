
import Foundation
import Utils

public protocol ArtWorker {
    func fetchArt(completion: @escaping (Result<[Art], Error>)->Void)
}

internal class ArtWorkerDefault {
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

        guard let networkRequest = getNetworkRequestResult().unwrapWithErrorHandler(completion) else {
            return
        }

        startFetchingWithNetworkRequest(networkRequest, completion: completion)
    }
}

private extension ArtWorkerDefault {

    func getNetworkRequestResult() -> Result<NetworkRequest, Error> {
        let artEndpoint = apiEndpoint()

        let apiRequest = apiRequestFromAPIEndpoint(artEndpoint)

        return networkRequestFromAPIRequest(apiRequest)
    }

    func startFetchingWithNetworkRequest(_ networkRequest: NetworkRequest, completion:@escaping (Result<[Art], Error>)->Void) {

        networkService.processNetworkRequest(networkRequest) { [weak self] (result) in

            guard let data = result.unwrapWithErrorHandler(completion) else {
                return
            }

            guard let art = self?.artFactoryResultFromData(data).unwrapWithErrorHandler(completion) else {
                return
            }

            completion(.success(art))
        }
    }

    func apiEndpoint() -> APIEndpoint {
        return .art
    }

    func apiRequestFromAPIEndpoint(_ apiEndpoint: APIEndpoint) -> APIRequest {
        return apiRequestFactory.apiRequest(fromAPIEndpoint: apiEndpoint)
    }

    func networkRequestFromAPIRequest(_ apiRequest: APIRequest) -> Result<NetworkRequest, Error> {
        return Result {
            try networkRequestFactory.networkRequest(fromAPIRequest: apiRequest)
        }
    }

    func artFactoryResultFromData(_ data: Data) -> Result<[Art], Error> {
        return Result{
            try artFactory.arts(fromJSONData: data)
        }
    }

}
