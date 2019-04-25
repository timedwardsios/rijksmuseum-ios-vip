
class PresenterSpy<ResponseType> {
    var presentArgs = [ResponseType]()
    func present(response: ResponseType) {
        presentArgs.append(response)
    }
}
