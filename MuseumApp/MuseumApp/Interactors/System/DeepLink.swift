import MuseumKit
import Combine

enum DeepLink {
    case showArtWithID(id: String)
}

extension DeepLink {
    init?(url: URL) {
        guard
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems,
            let deepLink = Self(queryItems: queryItems) else {
                return nil
        }
        self = deepLink
    }

    private init?(queryItems: [URLQueryItem]) {
        for queryItem in queryItems {
            switch (queryItem.name, queryItem.value) {
            case ("showArtWithID", let value?):
                self = .showArtWithID(id: value)
                return
            default: break
            }
        }
        return nil
    }
}
