
class DisplaySpy<ViewModelType> {
    var displayViewModelArgs = [ViewModelType]()
    func displayViewModel(response: ViewModelType) {
        displayViewModelArgs.append(response)
    }
}
