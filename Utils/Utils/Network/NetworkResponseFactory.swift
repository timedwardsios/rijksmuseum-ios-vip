
import Foundation

protocol NetworkResponseFactory {
    func createResponse(result: Result<Data, Error>)->NetworkResponse
}

class NetworkResponseFactoryDefault: NetworkResponseFactory{
    private struct NetworkResponseDefault: NetworkResponse {
        var result: Result<Data, Error>
    }

    func createResponse(result: Result<Data, Error>) -> NetworkResponse {
        return NetworkResponseDefault(result: result)
    }
}
