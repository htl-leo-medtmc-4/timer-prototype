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
        HStack {
            Spacer()
            Button(buttonText) {
                switch viewModel.status {
                case .paused: viewModel.resume(at: Date.now)
                case .running: viewModel.pause(at: Date.now)
                case .stopped: viewModel.start(at: Date.now)
                }
            }
            Spacer()
            Button("Reset") {
                viewModel.reset(at: Date.now)
            }.disabled(viewModel.status != .paused)
            Spacer()
        }
    }
}

#Preview {
    ButtonView(viewModel: TimerViewModel())
}
