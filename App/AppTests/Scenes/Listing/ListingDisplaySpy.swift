
@testable import App

class ListingDisplaySpy: ListingDisplaying {
    var displayViewModelArgs = [ListingViewModel]()
    func displayViewModel(_ viewModel: ListingViewModel) {
        displayViewModelArgs.append(viewModel)
    }
}

extension ListingViewModel: Equatable {
    public static func == (lhs: ListingViewModel, rhs: ListingViewModel) -> Bool {
        switch (lhs, rhs) {
        case (.imageUrl(let urlLeft), .imageUrl(let urlRight)):
            return urlLeft == urlRight
        }
    }
}
