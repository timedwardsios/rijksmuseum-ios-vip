
import Foundation

public protocol APIRequestInterface {
    var path:String {get}
    var queryItems:[URLQueryItem] {get}
}

public protocol APIConfigInterface:APIRequestInterface {
    var scheme:String {get}
    var hostname:String {get}
}

public protocol APISessionInterface {
    typealias DataTaskCompletion = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with url: URL,
                  completionHandler: @escaping DataTaskCompletion)-> URLSessionDataTask
}
extension URLSession:APISessionInterface{}
