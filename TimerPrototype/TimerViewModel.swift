//
//  TimerViewModel.swift
//  TimerPrototype
//
//  Created by Peter Bauer on 15.08.25.
//

import Foundation

@Observable public class TimerViewModel {
    public enum Status {
        case stopped, running, paused
    }
    
    public let defaultDuration = DateComponents(hour: 0, minute: 25, second: 0)

    private var duration: DateComponents
    private var endTime: Date?
    private var pauseTime: Date?
    
    public var status = Status.stopped
    
    public init() {
        duration = defaultDuration
    }
    
    public init(duration: (hours: Int, minutes: Int, seconds: Int)) {
        self.duration = DateComponents(hour: duration.hours, minute: duration.minutes, second: duration.seconds)
    }
    
    public func start(at startTime: Date) {
        let calendar = Calendar.current
        endTime = calendar.date(byAdding: duration, to: startTime)
        if endTime != nil {
            status = .running
        }
    }
    
    public func remainingTime(at date: Date) -> DateComponents? {
        var result: DateComponents?
        if let endTime = endTime {
            if let pauseTime = pauseTime {
                result = Calendar.current.dateComponents([.hour, .minute, .second], from: pauseTime, to: endTime)
            } else {
                result = Calendar.current.dateComponents([.hour, .minute, .second], from: date, to: endTime)
            }
        }
        return result
    }
    
    public func pause(at date: Date) {
        pauseTime = date
        status = .paused
    }
    
    public func reset(at date: Date) {
        status = .stopped
        pauseTime = nil
        endTime = nil
    }
    
    public func resume(at date: Date) {
        if let pauseTime = pauseTime {
            status = .running
            let timeSincePause = Calendar.current.dateComponents([.hour, .minute, .second], from: pauseTime, to: date)
            let secondsSincePause = Double(timeSincePause.hour!*3600 + timeSincePause.minute!*60 + timeSincePause.second!)
            let newEndtime = endTime?.addingTimeInterval(secondsSincePause)
            endTime = newEndtime
            self.pauseTime = nil
        }
    }
}
