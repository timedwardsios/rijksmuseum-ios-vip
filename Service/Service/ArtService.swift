
import Foundation
import Utils

// To be improved...

enum ArtServiceError: String,LocalizedError{
    case json = "JSON decoding error"
}

public protocol ArtService {
    func fetchArt(completion: @escaping (Result<[Art], Error>)->Void)
}

class ArtServiceDefault {
    let apiRequestFactory:APIRequestFactory
    let networkService: NetworkService
    init(apiRequestFactory:APIRequestFactory,
         networkService: NetworkService){
        self.apiRequestFactory = apiRequestFactory
        self.networkService = networkService
    }
}

extension ArtServiceDefault: ArtService {

    private struct APIEndpointArt: APIEndpoint{

        var path = "/collection"

        var queryItems = [URLQueryItem(name: "ps",
                                       value: "100"),
                          URLQueryItem(name: "imgonly",
                                       value: "true"),
                          URLQueryItem(name: "s",
                                       value: "relevance")]

    }

    func fetchArt(completion: @escaping (Result<[Art], Error>)->Void) {
        let request = try! apiRequestFactory.createRequest(withEndpoint: APIEndpointArt())

        networkService.processRequest(request) { (result) in
            switch result {
            case .success(let data):
                let dataResult = ArtServiceDefault.decodeJsonData(data)
                completion(dataResult)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension ArtServiceDefault {

    static func decodeJsonData(_ data:Data)->Result<[Art], Error>{
        let jsonDecoder = JSONDecoder()
        if let response = try? jsonDecoder.decode(ArtResponse.self, from: data) {
            return .success(response.artResponses)
        } else {
            return .failure(ArtServiceError.json)
        }
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
