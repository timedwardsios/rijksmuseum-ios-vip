
import Foundation
@testable import Service

//class APIServiceMock: APIService {
//    var performGetRequest_invocations = 0
//    var lastRequest:APIRequest?
//    var shouldReturnSuccess = true
//    var shouldReturnData = true
//    func performRequest( request: APIRequest,
//                     completion: @escaping (Result<Data, Error>) -> Void) {
//        performGetRequest_invocations += 1
//        lastRequest = request
//        let sampleData = ModelMock.Network.Endpoint.collection.data()
//        if shouldReturnSuccess {
//            if shouldReturnData {
//                completion(.success(sampleData))
//            } else {
//                completion(.success(Data()))
//            }
//        } else {
//            completion(.failure(ModelMock.Error.generic))
//        }
//    }
//}
