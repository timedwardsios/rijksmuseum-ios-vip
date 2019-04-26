
class PresenterSpy<ResponseType> {
    var presentResponseArgs = [ResponseType]()
    func presentResponse(response: ResponseType) {
        presentResponseArgs.append(response)
    }
}
