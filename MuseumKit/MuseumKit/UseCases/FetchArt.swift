import Foundation
import TimKit

public protocol ArtContainer {
    var arts: [Art] {get}
}

public protocol Art {

    var identifier: String { get }

    var title: String { get }

    var artist: String { get }

    var imageURL: URL { get }
}




public enum FetchArtError: LocalizedError {
    case requestError(Error), fetchError(Error), decodingError(Error)
}







public func fetchArt(apiService: APIService = resolve(),
                     artContainer: ArtContainer = resolve(),
                     completion: @escaping (Result<[Art], Error>) -> Void) {

    do {
        let apiRequest = try getAPIRequest()
        apiService.performAPIRequest(apiRequest) {

            let result = $0.flatMap { data in
                Result {
                    try [Art](fromJSONData: data)
                }
            }

            switch result {
            case .success(let arts):
                completion(.success(arts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    } catch let error {
        completion(.failure(FetchArtError.requestError(error)))
        return
    }
}

private func getAPIRequest() throws -> APIRequest {
    return try APIRequest(
        path: "/collection",
        queryItems: [
            "ps": "100",
            "imgonly": "true",
            "s": "relevance"
        ],
        method: APIMethod.GET
    )
}
