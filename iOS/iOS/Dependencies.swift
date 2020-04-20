import Foundation
import App
import Core

struct Dependencies {

    let useCases: UseCases

    init() {
        let services = Services(urlSession: .shared, jsonDecoder: JSONDecoder())
        let repositories = Repositories(services: services)
        self.useCases = UseCases(repositories: repositories)
    }
}
