struct ButtonView: View {
    var viewModel: TimerViewModel
    
    var buttonText: String {
        if viewModel.isActive {
            return "Stop"
        } else {
            return "Start"
        }
    }

    var body: some View {
        Button(buttonText) {
            if viewModel.isActive {
                viewModel.pause(at: Date())
            } else {
                viewModel.reset(at: Date())
                viewModel.start(at: Date())
            }
        }
    }
}
