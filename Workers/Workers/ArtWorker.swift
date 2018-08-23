
import Utilities

public protocol Art {
    var remoteId: String{get}
    var title: String{get}
    var artist: String{get}
    var imageUrl: URL{get}
}

//protocol ArtDetails {
//    var subtitle: String{get}
//    var description: String{get}
//}

public protocol ArtWorkerInput {
    func fetchArt(completion: @escaping (Result<[Art]>) -> Void)
}

public class ArtWorkerNetwork {
    let networkWorker:NetworkWorkerInput
    public init(networkWorker:NetworkWorkerInput) {
        self.networkWorker = networkWorker
    }
}

public protocol ArtWorkerNetworkInput:ArtWorkerInput{}

extension ArtWorkerNetwork: ArtWorkerNetworkInput {
    public func fetchArt(completion: @escaping (Result<[Art]>) -> Void) {
        let parameters = [URLQueryItem(name: Request.QueryItemName.pageCount.rawValue,
                                       value: "100"),
                          URLQueryItem(name: Request.QueryItemName.resultsWithImagesOnly.rawValue,
                                       value: "true"),
                          URLQueryItem(name: Request.QueryItemName.sortBy.rawValue,
                                       value: "relevance")]
        let request = Request(queryItems:parameters)
        networkWorker.performGet(request: request) { (result) in
            switch result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                guard let response = try? jsonDecoder.decode(ServerResponse.self, from: data) else {
                    completion(.failure(Error.json))
                    return
                }
                completion(.success(response.artResponses))
            case .failure(_):
                completion(.failure(Error.networkWorker))
            }
        }
    }
}

extension ArtWorkerNetwork {
    enum Error:Swift.Error{
        case networkWorker
        case json
    }

    struct Request:NetworkRequest {
        enum QueryItemName:String {
            case pageCount = "ps"
            case resultsWithImagesOnly = "imgonly"
            case sortBy = "s"
        }
        let endpoint = "/collection"
        let queryItems: [URLQueryItem]
    }

    struct ServerResponse: Decodable {
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

// Random core data shit
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "Rijksmuseum")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//        let result = Art(remoteId: "123",
//                               title: "A nice piece of art",
//                               artist: "Timothy Edwards",
//                               imageUrl: URL(string: "https://secure.gravatar.com/avatar/27e2d00ab3715b944d9ce99a421a012b?s=192&d=mm&r=g")!,
//                               starred: false)
//
//    func getArtDetails(_ art:Art) -> (Result<Art, Error>)->Void
//    func setArtStarred(_ art:Art, starred:Bool)
//
//    struct Error: LocalizedError {
//        public enum Reason {
//            case generic
//        }
//        public let reason: Reason
//        public var errorDescription: String?
//    }
