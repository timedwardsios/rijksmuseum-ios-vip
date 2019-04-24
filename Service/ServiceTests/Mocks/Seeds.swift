
import Foundation
import Utils
@testable import Service

public enum Seeds{

    struct APIConfigSeed: APIConfig{
        var scheme = Utils.Seeds.string
        var hostname = Utils.Seeds.string
        var path = Utils.Seeds.string
        var queryItems = [Utils.Seeds.urlQueryItem]
    }

    static let apiConfig = APIConfigSeed()
}
