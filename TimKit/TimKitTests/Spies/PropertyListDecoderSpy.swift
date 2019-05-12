import Foundation
@testable import TimKit

class PropertyListDecoderSpy: TimKit.PropertyListDecoder {

    var decodeArgs = [Data]()

    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        decodeArgs.append(data)
        return try PropertyListDecoder().decode(type, from: data)
    }
}
