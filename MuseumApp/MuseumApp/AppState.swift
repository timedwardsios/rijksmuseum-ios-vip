import MuseumDomain
import Utils
import Combine

public class AppState {

    public init() { }

    @Published var arts: Loadable<[Art]> = .notRequested

    @Published public var isActive: Bool = false

    /*
     Note the "previous" value of route is unreliable as we have no way of hooking into "back"
     navigation events: https://github.com/ReSwift/ReSwift-Router/issues/17
     This somewhat breaks our idea of centralised state but with UIKit there's no real alternative.
     Because of this, route must be a simple publisher rather than have a backing value.
     */

    public var routePublisher = PassthroughSubject<Route, Never>()
}


public extension AppState {
    indirect enum Route {
        case artCollection
        case artDetails(artID: String)
        case alert(Alert)
    }
}
