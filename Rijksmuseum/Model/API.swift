
import Foundation

protocol HasQueryItems {
    var queryItems:[URLQueryItem] {get}
}

protocol HasEndpoint {
    var endpoint:String {get}
}

protocol HasBaseURL {
    var scheme:String {get}
    var hostname:String {get}
    var path:String {get}
}

typealias APIConfig = HasBaseURL & HasQueryItems
typealias APIRequest = HasEndpoint & HasQueryItems

protocol APISession {
    typealias DataTaskCompletion = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with url: URL, completionHandler: @escaping DataTaskCompletion) -> URLSessionDataTask
}
extension URLSession:APISession{}
