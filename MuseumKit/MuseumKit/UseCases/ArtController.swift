import Foundation
import TimKit

public protocol Art {
    var id: String { get }
    var title: String { get }
    var artist: String { get }
    var imageURL: URL { get }
}









public protocol ArtController {
    func fetchArt()
}

class ArtControllerDefault {

    let apiService: APIService
    let model: Model

    init(apiService: APIService,
         model: Model) {
        self.apiService = apiService
        self.model = model
    }
}

extension ArtControllerDefault: ArtController {
    
    func fetchArt() {


        let request = try! APIRequest(
            path: "/collection",
            queryItems: [
                "ps": "100",
                "imgonly": "true",
                "s": "relevance"
            ],
            method: APIMethod.GET
        )

        let artAPIOperation = APIOperation.init(request: request, responseFormat: RootJSON.self)

        apiService.performAPIOperation(artAPIOperation) {
            switch $0 {
            case let .success(data):
                print(data)
            case let .failure(error):
                print(error)
            }
        }
    }
}


private struct ArtJSON: Art, Decodable {

    var id: String
    var title: String
    var artist: String
    var imageURL: URL

    enum CodingKeys: String, CodingKey {
        case artArray = "artObjects"
        case id = "objectNumber"
        case title = "title"
        case artist = "principalOrFirstMaker"
        case imageDict = "webImage"
        case imageURL = "url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.artist = try container.decode(String.self, forKey: .artist)
        let webImage = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageDict)
        self.imageURL = try webImage.decode(URL.self, forKey: .imageURL)
    }
}

private struct RootJSON: Decodable {

    let artJSONs: [ArtJSON]

    private enum CodingKeys: String, CodingKey {
        case artArray = "artObjects"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        artJSONs = try container.decode([ArtJSON].self, forKey: .artArray)
    }
}
