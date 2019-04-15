public enum State<T,E> {
    case loading
    case loaded(T)
    case error(E)
}
