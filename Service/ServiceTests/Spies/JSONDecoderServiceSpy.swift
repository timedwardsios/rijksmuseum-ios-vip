
import Foundation
import Utils
@testable import Service

class JSONDecoderServiceSpy: Service.JSONDecoderService {

    var decodeResult: Result<Any, Error>

    init(decodeResult: Result<Any, Error>) {
        self.decodeResult = decodeResult
    }

    var decodeArgs = [Data]()

    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        decodeArgs.append(data)
        let object = try decodeResult.get()
        return object as! T
    }
}
