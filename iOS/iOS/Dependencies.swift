import Foundation
import App
import Core

struct Dependencies {

    let useCases: UseCases

    init() {
        let urlSession = URLSession.shared
        let jsonDecoder = JSONDecoder()
        let services = Services(urlSession: urlSession, jsonDecoder: jsonDecoder)
        let repositories = Repositories(services: services)
        self.useCases = UseCases(repositories: repositories)
    }
}
