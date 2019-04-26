
class InteractorSpy<ResultType> {
    var processRequestArgs = [ResultType]()
    func processRequest(response: ResultType) {
        processRequestArgs.append(response)
    }
}
