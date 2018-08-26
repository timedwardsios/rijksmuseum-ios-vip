
import Foundation
import Utils
import Service

enum Seeds{
    enum ErrorSeed:String,ResultError {
        case generic = "49F6409E-76BF-41E4-A049-80C905922E7C"
    }

//    enum Model {
//        class ArtSeed:Art{
//            var remoteId = "remoteId seed"
//            var title = "title seed"
//            var artist = "artist seed"
//            var imageUrl = URL(string: "http://www.apple.com")!
//        }
//    }
//
    enum API{
        struct Config:APIConfig{
            let scheme:String = "https"
            let hostname = "hostname.com"
            let path = "/path/to/api"
            let queryItems = [URLQueryItem(name : "configKey",
                                           value: "configValue")]
        }

        struct Request: APIRequest {
            let path = "/endpointseed"
            let queryItems = [URLQueryItem(name: "requestKey",
                                           value: "requestValue")]
        }

        enum Endpoint:String {
            case collection = "/collection"
            func data()->Data{
                class BundleClass{}
                var fileName = self.rawValue
                fileName.removeFirst()
                let url = Bundle.init(for: BundleClass.self).url(forResource: fileName,
                                                            withExtension: "json")!
                return try! Data(contentsOf: url)
            }
        }

        static func fullUrl()->URL{
            return URL(string:"https://hostname.com/path/to/api/endpointseed?configKey=configValue&requestKey=requestValue")!
        }
    }
}
