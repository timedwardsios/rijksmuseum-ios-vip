public extension Result {

    func unwrapWithErrorHandler<T>(_ errorHandler: ((Result<T, Error>) -> Void)) -> Success? {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            errorHandler(.failure(error))
        }
        return nil
    }

    func unwrap() -> Success? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }

    func unwrapError() -> Failure? {
        if case .failure(let error) = self {
            return error
        }
        return nil
    }

    var isSuccess: Bool {
        if case .success(_) = self {
            return true
        }
        return false
    }

    var isFailure: Bool {
        if case .failure(_) = self {
            return true
        }
        return false
    }
}
