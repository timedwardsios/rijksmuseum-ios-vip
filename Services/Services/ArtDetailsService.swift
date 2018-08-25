
import Utilities

public typealias ArtDetailsServiceDependencies = HasApiService

public protocol ArtDetailsServiceInterface {
    func fetchArt(completion: @escaping (Result<[Art]>)->Void)
}

public class ArtDetailsServiceAPI {
    let apiService:APIServiceInterface
    public init(dependencies:ArtDetailsServiceDependencies) {
        self.apiService = dependencies.apiService
    }
}

extension ArtDetailsServiceAPI: ArtDetailsServiceInterface {
    public func fetchArt(completion: @escaping (Result<[Art]>)->Void) {
        let request = ArtRequest()
        apiService.performGet(request: request) {(result) in
            switch result {
            case .success(let data):
                let dataResult = self.decodeJsonData(data)
                completion(dataResult)
            case .failure(_):
                completion(.failure(ServiceError.apiService))
            }
        }
    }
}

private extension ArtDetailsServiceAPI {
    enum ServiceError:String,ResultError{
        case apiService
        case json
    }

    func decodeJsonData(_ data:Data)->Result<[Art]>{
        let jsonDecoder = JSONDecoder()
        guard let response = try? jsonDecoder.decode(ArtResponse.self, from: data) else {
            return .failure(ServiceError.json)
        }
        return .success(response.artResponses)
    }

    struct ArtRequest:APIRequest {
        enum QueryItemName:String {
            case pageCount = "ps"
            case resultsWithImagesOnly = "imgonly"
            case sortBy = "s"
        }
        let path = "/collection"
        let queryItems = [URLQueryItem(name: QueryItemName.pageCount.rawValue,
                                       value: "100"),
                          URLQueryItem(name: QueryItemName.resultsWithImagesOnly.rawValue,
                                       value: "true"),
                          URLQueryItem(name: QueryItemName.sortBy.rawValue,
                                       value: "relevance")]
    }

    struct ArtResponse: Decodable {
        struct ArtResponse: Art, Decodable {
            var remoteId: String
            var title: String
            var artist: String
            var imageUrl: URL

            enum CodingKeys: String, CodingKey {
                case remoteId = "objectNumber"
                case title = "title"
                case artist = "principalOrFirstMaker"
                case imageDict = "webImage"
                case imageUrl = "url"
            }

            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.remoteId = try container.decode(String.self, forKey: .remoteId)
                self.title = try container.decode(String.self, forKey: .title)
                self.artist = try container.decode(String.self, forKey: .artist)
                let webImage = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageDict)
                self.imageUrl = try webImage.decode(URL.self, forKey: .imageUrl)
            }
        }

        let artResponses: [ArtResponse]

        private enum CodingKeys: String, CodingKey {
            case artResponses = "artObjects"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            artResponses = try container.decode([ArtResponse].self, forKey: .artResponses)
        }
    }
}
