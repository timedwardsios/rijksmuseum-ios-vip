import Foundation

public protocol ArtDetailsService {
    func fetchArt(completion: @escaping (Result<[Art], Error>)->Void)
}

class ArtDetailsServiceDefault {
    let apiService:APIService
    init(apiService:APIService = DependenciesDefault.apiService) {
        self.apiService = apiService
    }
}

extension ArtDetailsServiceDefault: ArtDetailsService {
    func fetchArt(completion: @escaping (Result<[Art], Error>)->Void) {
        let request = ArtRequest()
        apiService.performGet(request: request) {(result) in
            switch result {
            case .success(let data):
                let dataResult = self.decodeJsonData(data)
                completion(dataResult)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension ArtDetailsServiceDefault {
    enum ServiceError:String,Error{
        case json
    }

    func decodeJsonData(_ data:Data)->Result<[Art], Error>{
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
            var id: String
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
                self.id = try container.decode(String.self, forKey: .remoteId)
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
