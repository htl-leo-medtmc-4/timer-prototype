//
//  AnalogClockView.swift
//  TimerPrototype
//
//  Created by Peter Bauer on 13.08.25.
//

import SwiftUI

struct AnalogClockView: View {
    private var viewModel = TimerViewModel()
    

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0, paused: false)) { context in
            let date = context.date
            TimerView(viewModel: viewModel, date: date)
        }
        Spacer()
        ButtonView(viewModel: viewModel)
    }
}

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

struct TimerView: View {
    var viewModel: TimerViewModel
    let date: Date

    var remainingTime: (Int, Int, Int) {
        var result: (hour: Int, minute: Int, second: Int) = (0, 0, 0)
        if let r = viewModel.remainingTime(at: date) {
            result = (r.hour!, r.minute!, r.second!)
        }
        return result
    }
    
    var body: some View {
        ClockFaceView(date: date, hours: remainingTime.0, minutes: remainingTime.1, seconds: remainingTime.2)
    }
}

struct ClockFaceView: View {
    let date: Date
    let hours: Int
    let minutes: Int
    let seconds: Int
    
    var formattedTimerText: Text {
        return Text("\(hours, specifier: "%02d"): \(minutes, specifier: "%02d"): \(seconds, specifier: "%02d")")
    }
    
    var body: some View {
        let calendar = Calendar.current
        let second = Double(calendar.component(.second, from: date))
        let minute = Double(calendar.component(.minute, from: date))
        let hour = Double(calendar.component(.hour, from: date)) + minute / 60.0
                        
        ZStack {
            Circle()
                .stroke(lineWidth: 4)
                .frame(width: .infinity, height: .infinity)
            
            // Hour hand
            Rectangle()
                .fill(Color.primary)
                .frame(width: 4, height: 50)
                .offset(y: -25)
                .rotationEffect(.degrees(hour / 12 * 360))
            
            // Minute hand
            Rectangle()
                .fill(Color.primary)
                .frame(width: 2, height: 70)
                .offset(y: -35)
                .rotationEffect(.degrees(minute / 60 * 360))
            
            // Second hand
            Rectangle()
                .fill(Color.red)
                .frame(width: 1, height: 90)
                .offset(y: -45)
                .rotationEffect(.degrees(second / 60 * 360))
        }
        .frame(width: 200, height: 200)
        Text("\(Int(minute), specifier: "%02d") : \(Int(second), specifier: "%02d")")
        Spacer()
        Text("Timer")
        formattedTimerText
    }
}

#Preview {
    AnalogClockView()
}
