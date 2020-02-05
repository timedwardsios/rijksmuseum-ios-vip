import MuseumKit
import TimKit
import Combine

public class AppState {

    public init() { }

    @Published var arts: Loadable<[Art]> = .notRequested

    @Published public var isActive: Bool = false

    public var routePublisher = PassthroughSubject<Route, Never>()
}


public extension AppState {
    indirect enum Route {
        case artCollection
        case artDetails(artID: String)
        case alert(Alert)
    }
}
