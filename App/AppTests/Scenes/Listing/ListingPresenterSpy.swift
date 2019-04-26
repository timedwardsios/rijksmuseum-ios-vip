
@testable import App

class ListingPresenterSpy: ListingPresenting {
    var presentResponseArgs = [ListingResponse]()
    func presentResponse(_ response: ListingResponse) {
        presentResponseArgs.append(response)
    }
}

extension ListingResponse: Equatable {
    public static func == (lhs: ListingResponse, rhs: ListingResponse) -> Bool {
        switch (lhs, rhs) {
        case (.didLoadArt(let artLeft), .didLoadArt(let artRight)):
            return (artLeft as? ArtMock) == (artRight as? ArtMock)
        }
    }
}
