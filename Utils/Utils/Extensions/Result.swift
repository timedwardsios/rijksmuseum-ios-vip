
// Can now use Void Result types with simply .success

public extension Result where Success == Void {
    static var success: Result {
        return .success(())
    }
}
