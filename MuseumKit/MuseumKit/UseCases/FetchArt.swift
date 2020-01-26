import Foundation
import TimKit

public protocol HasArts: class {
    var arts: [Art] {get set}
}

public protocol Art {

    var id: String { get }

    var title: String { get }

    var artist: String { get }

    var imageURL: URL { get }
}




public enum FetchArtError: LocalizedError {
    case requestError(Error), fetchError(Error), decodingError(Error)
}







public func fetchArt(apiService: APIService = resolve(),
                     model: HasArts = resolve()) {

    do {
        let apiRequest = try getAPIRequest()
        apiService.performAPIRequest(apiRequest) {

            do {
                let data = try $0.get()
                let arts = try [Art](fromJSONData: data)

                DispatchQueue.main.async {
                    model.arts = arts
                }
            } catch {}

            //            switch result {
            //            case .success(let arts):
            //                artContainer.arts = arts
            //            case .failure(let error):
            //                completion(.failure(error))
            //            }
        }
    } catch let error {
        //        completion(.failure(FetchArtError.requestError(error)))
        //        ??????
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
