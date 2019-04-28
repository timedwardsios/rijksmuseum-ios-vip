
public extension Result {

    func unwrap() -> Success? {
        if case .success(let success) = self {
            return success
        }
        return nil
    }

    func unwrapError() -> Failure? {
        if case .failure(let failure) = self {
            return failure
        }
        return nil
    }

    var isSuccess: Bool {
        return unwrap() != nil
    }

    var isFailure: Bool {
        return unwrap() == nil
    }
}
