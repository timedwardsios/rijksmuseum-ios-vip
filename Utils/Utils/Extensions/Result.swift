
// Can now use Void Result types with simply .success

public extension Result where Success == Void {
    static var success: Result {
        return .success(())
    }
}

public extension Result {
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
}
