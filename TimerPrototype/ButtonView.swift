//
//  ButtonView.swift
//  TimerPrototype
//
//  Created by Peter Bauer on 01.09.25.
//

import SwiftUICore
import SwiftUI


struct ButtonView: View {
    var viewModel: TimerViewModel
    
    var buttonText: String {
        viewModel.isActive ? "Stop" : "Start"
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

#Preview {
    ButtonView(viewModel: TimerViewModel())
}
