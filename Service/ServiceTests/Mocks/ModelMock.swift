
import Foundation
import Utils
@testable import Service

enum ModelMock{
    enum Error:String, Swift.Error {
        case generic = "49F6409E-76BF-41E4-A049-80C905922E7C"
    }

    struct APIRequest: Service.APIRequest {
        let path = "/endpointseed"
        let queryItems = [URLQueryItem(name: "requestKey",
                                       value: "requestValue")]
    }

    enum API{


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
