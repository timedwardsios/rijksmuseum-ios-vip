
import Foundation

struct PortfolioViewModel {
    enum State {
        case loading
        case loaded([URL])
        case error(String)
    }
    let state: State
}
