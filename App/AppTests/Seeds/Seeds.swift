
import Workers
@testable import App

enum Seeds{
    class ErrorSeed:Error {
        var localizedDescription: String{
            return "49F6409E-76BF-41E4-A049-80C905922E7C"
        }
    }

    enum Model {
        class ArtSeed:Art{
            var remoteId = "remoteId seed"
            var title = "title seed"
            var artist = "artist seed"
            var imageUrl = URL(string: "http://www.apple.com")!
        }
    }

    enum Network{
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
            return URL(string:"https://hostname.seed/path/to/network/endpointseed?configKey=configValue&requestKey=requestValue")!
        }
    }
}
