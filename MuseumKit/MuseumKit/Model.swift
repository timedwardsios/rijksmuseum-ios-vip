import Foundation
import TimKit

class Model: ObservableObject, ArtContainer {
    @Published var arts = [Art]()
}
