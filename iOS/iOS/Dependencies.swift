import Foundation
import App
import Core

struct Dependencies {

    let useCases: UseCases

    init() {
        let urlSession = URLSession.shared
        let jsonDecoder = JSONDecoder()
        let repositories = Repositories(urlSession: urlSession,
                                        jsonDecoder: jsonDecoder)
        self.useCases = UseCases(repositories: repositories)
    }
}
