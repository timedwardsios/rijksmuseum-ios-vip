import Foundation
import TimKit

import Combine

public protocol ArtController {
    func fetchArt(_ handler: @escaping ResultHandler<[Art]>)
}

class ArtControllerDefault {

    let apiService: APIService
    let model: Model

    init(apiService: APIService,
         model: Model) {
        self.apiService = apiService
        self.model = model
    }

    var cancellable: AnyCancellable?
}

extension ArtControllerDefault: ArtController {
    
    func fetchArt(_ handler: @escaping ResultHandler<[Art]>) {

        let future = Future<[Art], Error> { callback in
            self.apiService.performAPIOperation(FetchArtAPIOperation()) {
                print("wtf m8")
                let artResult = $0.map({ $0.artJSONs as [Art] })
                callback(artResult)
                callback(artResult)
                callback(artResult)
                callback(artResult)
            }
        }

        
        cancellable = future.sink(
            receiveCompletion: {
                switch $0 {
                case .finished:
                    print("Finished")
                case let .failure(error):
                    print(error.localizedDescription)
                }
        },
            receiveValue: {
                print($0)
        })
    }
}

private struct FetchArtAPIOperation: APIOperation {
    var path = "/collection"
    let queryItems = [
        "ps": "100",
        "imgonly": "true",
        "s": "relevance"
    ]
    let method = APIMethod.GET
    let responseType = RootJSON.self
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
