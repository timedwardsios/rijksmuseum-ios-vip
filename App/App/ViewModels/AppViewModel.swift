import Foundation
import Core
import Combine
import Utils

public struct AppViewModel {

    public struct Inputs {
        public let didFinishLaunching = PassthroughSubject<Void, Never>()
        public let didEnterBackground = PassthroughSubject<Void, Never>()
        public let willEnterForeground = PassthroughSubject<Void, Never>()
        public let didOpenURL = PassthroughSubject<URL, Never>()
    }

    public let inputs = Inputs()

    private let cancelBag = CancelBag()

    public init() {
        bind()
    }

    func bind() {
//        inputs.didFinishLaunching.
    }
}

extension AppViewModel {
    public func didFinishLaunching() {
//        appState.lifecycle.accept(.launched)
    }

    public func didEnterBackground() {
//        appState.lifecycle.accept(.background)
    }

    public func willEnterForeground() {
//        appState.lifecycle.accept(.foreground)
    }

    public func didOpenURL(_ url: URL) {
        handleDeepLink(withURL: url)
    }
}

private extension AppViewModel {
    func handleDeepLink(withURL url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else {
            return
        }

        for queryItem in queryItems {
//            switch (queryItem.name, queryItem.value) {
//            case let ("showArtWithID", value?):
////                appState.currentRoute.accept(.artDetails(artID: value))
//                return
//            default:
//                break
//            }
        }
    }
}
