
import Foundation

protocol HasBaseUrl {
    var baseUrl:URL {get}
}

protocol HasEndpoint {
    var endpoint:String {get}
}

protocol HasParameters {
    var parameters:[String:String] {get}
}

typealias APIConfig = HasBaseUrl & HasParameters
typealias APIRequest = HasEndpoint & HasParameters

enum APIData{
    enum Live {
        struct Config:APIConfig{
            enum ParameterKey:String {
                case apiKey = "apiKey"
                case format = "format"
            }
            let parameters = [ParameterKey.apiKey.rawValue : "VV23OnI1",
                              ParameterKey.format.rawValue : "json"]
            let baseUrl = URL(string: "rijksmuseum.nl/api/en")!
        }

        struct Request:APIRequest {
            enum Endpoint:String {
                case collection = "collection"
                case details = "details"
            }
            enum ParameterKey:String {
                case pageCount = "ps"
                case resultsWithImagesOnly = "imgonly"
                case sortBy = "s"
            }

            var endpoint: Endpoint.RawValue
            var parameters: [ParameterKey.RawValue : String]
        }
    }
}
