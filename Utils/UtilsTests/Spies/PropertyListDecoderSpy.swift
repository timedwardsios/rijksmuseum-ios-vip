import Foundation
@testable import Utils

class PropertyListDecoderServiceSpy: PropertyListDecoderService {

    var decodeArgs = [Data]()

    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {

        decodeArgs.append(data)

        return try PropertyListDecoder().decode(type, from: data)
    }
}
