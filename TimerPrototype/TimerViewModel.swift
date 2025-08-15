//
//  TimerViewModel.swift
//  TimerPrototype
//
//  Created by Peter Bauer on 15.08.25.
//

import Foundation

public struct TimerViewModel {
    public private(set) var isActive: Bool = false
    private var endTime: Date?
    
    public init() {}
    
    public mutating func start(_ startTime: Date) {
        isActive = true
        self.endTime = startTime.addingTimeInterval(25*60)
    }
    
    public func remainingSeconds(at date: Date) -> DateComponents? {
        var result: DateComponents?
        if let endTime = endTime {
            result = Calendar.current.dateComponents([.second], from: date, to: endTime)
        }
        return result
    }
    
    public mutating func stop() {
        isActive = false
    }
}
