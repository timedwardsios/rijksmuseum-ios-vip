public extension Result {

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
}
