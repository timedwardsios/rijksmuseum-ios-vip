import Foundation
import TimKit

public protocol ArtService {
    func fetchArt(completion: @escaping (Result<[Art], Error>) -> Void)
    func cancelAllTasks()
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

    var currentTask: NetworkSessionDataTask?
}

extension ArtServiceDefault: ArtService {

    func fetchArt(completion: @escaping (Result<[Art], Error>) -> Void) {

        let networkRequestResult = createNetworkRequestResult()

        switch networkRequestResult {
        case .success(let networkRequest):
            startFetchingWithNetworkRequest(networkRequest, completion: completion)
        case .failure(let error):
            completion(.failure(error))
        }
    }

    func cancelAllTasks() {
        cancelCurrentTask()
    }
}

private extension ArtServiceDefault {

    func cancelCurrentTask() {
        currentTask?.cancel()
        currentTask = nil
    }

    func createNetworkRequestResult() -> Result<NetworkRequest, Error> {

        return networkRequestFactory.networkRequest(fromAPIRequest: apiRequestConfig.collection)
    }

    func startFetchingWithNetworkRequest(_ networkRequest: NetworkRequest,
                                         completion:@escaping (Result<[Art], Error>) -> Void) {

        currentTask = networkService.processNetworkRequest(networkRequest) { [weak self] (result) in

            self?.didFetchWithResult(result, completion: completion)
        }
    }

    func didFetchWithResult(_ result: Result<Data, Error>, completion: (Result<[Art], Error>) -> Void) {
        switch result {
        case .success(let data):
            createArtsFromData(data, completion: completion)
        case .failure(let error):
            completion(.failure(error))
        }
    }

    func createArtsFromData(_ data: Data, completion: (Result<[Art], Error>) -> Void) {

        let artResult = artFactory.arts(fromJSONData: data)

        switch artResult {
        case .success(let art):
            completion(.success(art))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
