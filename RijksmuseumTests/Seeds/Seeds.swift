
import Foundation
@testable import Rijksmuseum

enum Seeds{
    struct ErrorSeed:Error {}

    enum Model {
        struct ArtPrimitiveSeed:ArtPrimitive{
            var remoteId = "remoteId seed"
            var title = "title seed"
            var artist = "artist seed"
            var imageUrl = URL(string: "http://www.apple.com")!
        }
    }

    enum API{
        struct Config:APIConfig{
            let scheme:String = "https"
            let hostname = "hostname.seed"
            let path = "/path/to/api"
            let queryItems = [URLQueryItem(name : "configKey",
                                           value: "configValue")]
        }

        struct Request: APIRequest {
            let endpoint = "/endpointseed"
            let queryItems = [URLQueryItem(name: "requestKey",
                                           value: "requestValue")]
        }

        enum Endpoint:String {
            case collection
            func data()->Data{
                class BundleClass{}
                let url = Bundle.init(for: BundleClass.self).url(forResource: self.rawValue,
                                                            withExtension: "json")!
                return try! Data(contentsOf: url)
            }
        }

        static func fullUrl()->URL{
            return URL(string:"https://hostname.seed/path/to/api/endpointseed?configKey=configValue&requestKey=requestValue")!
        }
    }
}
