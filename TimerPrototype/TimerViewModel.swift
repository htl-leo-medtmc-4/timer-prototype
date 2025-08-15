//
//  TimerViewModel.swift
//  TimerPrototype
//
//  Created by Peter Bauer on 15.08.25.
//

import Foundation

public struct TimerViewModel {
    public private(set) var isActive: Bool = false
    public init() {}
    public mutating func start(_ startTime: Date) {
        isActive = true
    }
    
    public func remainingSeconds(at date: Date) -> Int {
        return 25 * 60
    }
    
    public mutating func stop() {
        isActive = false
    }
}
