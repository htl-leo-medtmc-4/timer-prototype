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
        return switch viewModel.status {
            case .paused: "Resume"
            case .running: "Pause"
            case .stopped: "Start"
        }
    }

    var body: some View {
        Button(buttonText) {
            switch viewModel.status {
                case .paused: viewModel.resume(at: Date.now)
                case .running: viewModel.pause(at: Date.now)
                case .stopped: viewModel.start(at: Date.now)
            }
        }
    }
}

#Preview {
    ButtonView(viewModel: TimerViewModel())
}
