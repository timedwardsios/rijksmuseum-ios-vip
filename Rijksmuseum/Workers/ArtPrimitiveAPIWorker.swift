
import Foundation

typealias ArtPrimitiveResult = Result<[ArtPrimitive], Error>

protocol ArtPrimitiveWorker {
    func fetchPrimitives(completion: @escaping (ArtPrimitiveResult) -> Void)
}

class ArtPrimitiveAPIWorker: ArtPrimitiveWorker{
    enum WorkerError:String,Error{
        case apiServiceError
        case jsonError
    }

    struct Request:APIRequest {
        enum QueryItemName:String {
            case pageCount = "ps"
            case resultsWithImagesOnly = "imgonly"
            case sortBy = "s"
        }
        let endpoint = "collection"
        let queryItems: [URLQueryItem]
    }

    private struct Response: Decodable {
        struct Primitive: ArtPrimitive, Decodable {
            var remoteId: String
            var title: String
            var artist: String
            var imageUrl: URL

            private enum CodingKeys: String, CodingKey {
                case objectNumber
                case title
                case principalOrFirstMaker
                case imageUrl
                case webImage
                case url
            }

            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.remoteId = try container.decode(String.self, forKey: .objectNumber)
                self.title = try container.decode(String.self, forKey: .title)
                self.artist = try container.decode(String.self, forKey: .principalOrFirstMaker)
                let webImage = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .webImage)
                self.imageUrl = try webImage.decode(URL.self, forKey: .url)
            }
        }

        let primitives: [Primitive]

        private enum CodingKeys: String, CodingKey {
            case artObjects
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            primitives = try container.decode([Primitive].self, forKey: .artObjects)
        }
    }

    let apiService:APIServiceInterface
    init(apiService:APIServiceInterface) {
        self.apiService = apiService
    }

    func fetchPrimitives(completion: @escaping (Result<[ArtPrimitive], Error>) -> Void) {
        let parameters = [URLQueryItem(name: Request.QueryItemName.pageCount.rawValue,
                                       value: "100"),
                          URLQueryItem(name: Request.QueryItemName.resultsWithImagesOnly.rawValue,
                                       value: "true"),
                          URLQueryItem(name: Request.QueryItemName.sortBy.rawValue,
                                       value: "relevance")]
        let request = Request(queryItems:parameters)
        apiService.performGet(request: request) { (result) in
            switch result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                guard let response = try? jsonDecoder.decode(Response.self, from: data) else {
                    completion(.failure(WorkerError.jsonError))
                    return
                }
                completion(.success(response.primitives))
            case .failure(_):
                completion(.failure(WorkerError.apiServiceError))
            }
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
