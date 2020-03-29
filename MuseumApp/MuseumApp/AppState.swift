import MuseumDomain
import Utils
import Combine

public class AppState {

    @Published var arts: Loadable<[Art]> = .notRequested

    @Published public var lifecycle: Lifecycle = .launching

    @Published public var currentRoute: Route = .artCollection

    public init() { }
}

public extension AppState {

    enum Lifecycle {
        case launching
        case launched
        case background
        case foreground
    }

    enum Route {
        case artCollection
        case artDetails(artID: String)
        case alert(Alert)
    }
}
