import MuseumApp
import MuseumCore

class Dependencies: ViewModelFactory {
    var urlSession = URLSession.shared
    var jsonDecoder = JSONDecoder()
}
