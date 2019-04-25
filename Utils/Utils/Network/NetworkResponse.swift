
import Foundation

protocol NetworkResponse {
    var data: Data? {get}
    var urlResponse: URLResponse? {get}
    var error: Error? {get}
}
