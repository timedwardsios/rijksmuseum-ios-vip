
import Foundation

protocol APIConfig {
    var path: String {get}
    var queryItems: [URLQueryItem] {get}
    var scheme: String {get}
    var host: String {get}
}
