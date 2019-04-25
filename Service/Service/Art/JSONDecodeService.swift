
import Foundation
import Utils

public protocol JSONDecodeService {
    func decodeData<T:Decodable>(_ data: Data, fromType type:T)
}

class JSONDecodeServiceDefault {
    let jsonDecoder: JSONDecoder
    init(jsonDecoder: JSONDecoder){
        self.jsonDecoder = jsonDecoder
    }
}

extension JSONDecodeServiceDefault: JSONDecodeService {
    func decodeData<T>(_ data: Data, fromType type: T) where T : Decodable {
        //
    }
}

private extension JSONDecodeServiceDefault {
    enum LocalError: String,LocalizedError{
        case unknown
    }

    static func decodeJsonData(_ data:Data)->Result<[Art], Error>{
        let jsonDecoder = JSONDecoder()
        if let response = try? jsonDecoder.decode(ArtResponse.self, from: data) {
            return .success(response.artResponses)
        } else {
            return .failure(LocalError.unknown)
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
