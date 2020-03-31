import MuseumApp
import MuseumCore

let viewModelFactory: ViewModelFactory = {
    let urlSession = URLSession.shared
    let jsonDecoder = JSONDecoder()
    let serviceFactory = ServiceFactory(urlSession: urlSession, jsonDecoder: jsonDecoder)
    let repositoryFactory = RepositoryFactory(serviceFactory: serviceFactory)
    let useCaseFactory = UseCaseFactory(repositoryFactory: repositoryFactory)
    return ViewModelFactory(useCaseFactory: useCaseFactory)
}()
