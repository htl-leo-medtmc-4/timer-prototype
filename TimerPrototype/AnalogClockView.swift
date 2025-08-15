//
//  AnalogClockView.swift
//  TimerPrototype
//
//  Created by Peter Bauer on 13.08.25.
//

import SwiftUI

struct AnalogClockView: View {
    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0, paused: false)) { context in
            let date = context.date
            ClockFaceView(date: date)
        }
    }
}

struct ClockFaceView: View {
    let date: Date
    
    var body: some View {
        let calendar = Calendar.current
        let second = Double(calendar.component(.second, from: date))
        let minute = Double(calendar.component(.minute, from: date))
        let hour = Double(calendar.component(.hour, from: date)) + minute / 60.0
        
        ZStack {
            Circle()
                .stroke(lineWidth: 4)
            
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
    }
}

#Preview {
    AnalogClockView()
}
