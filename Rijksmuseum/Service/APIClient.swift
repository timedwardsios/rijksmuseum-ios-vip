
import Foundation

protocol APIClientInterface {
    func get(_ request: APIRequest, completionHandler: @escaping (Result<Data,Error>) -> Void)
}

class APIClient:APIClientInterface{
    let networkSession: NetworkSession
    let apiConfig: APIConfig

    init(networkSession:NetworkSession,
         apiConfig: APIConfig) {
        self.networkSession = networkSession
        self.apiConfig = apiConfig
    }

    func get(_ request: APIRequest, completionHandler: @escaping (Result<Data,Error>) -> Void){
        // todo
    }
}
