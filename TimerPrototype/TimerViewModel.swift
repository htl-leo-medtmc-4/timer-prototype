//
//  TimerViewModel.swift
//  TimerPrototype
//
//  Created by Peter Bauer on 15.08.25.
//

import Foundation

public struct TimerViewModel {
    public let defaultDuration = DateComponents(hour: 0, minute: 25, second: 0)
    public private(set) var isActive: Bool = false

    private var duration: DateComponents
    private var endTime: Date?
    
    public init() {
        duration = defaultDuration
    }
    
    public mutating func start(_ startTime: Date) {
        let calendar = Calendar.current
        endTime = calendar.date(byAdding: duration, to: startTime)
        if endTime != nil {
            isActive = true
        }
    }
    
    public func remainingSeconds(at date: Date) -> DateComponents? {
        var result: DateComponents?
        if let endTime = endTime {
            result = Calendar.current.dateComponents([.hour, .minute, .second], from: date, to: endTime)
        }
        return result
    }
    
    public mutating func pause() {
        isActive = false
    }
}
