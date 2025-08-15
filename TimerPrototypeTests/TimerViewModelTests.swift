//
//  TimerViewModelTests.swift
//  TimerPrototypeTests
//
//  Created by Peter Bauer on 15.08.25.
//

import Testing
import Foundation
import TimerPrototype

struct TimerViewModelTests {

    @Test func itShouldBeInactive_GivenConstructed() async throws {
        // arrange (and act)
        let viewModel = TimerViewModel()
        
        // assert
        #expect(!viewModel.isActive)
    }
    
    @Test func itShouldBeActive_GivenStarted() async throws {
        // arrange
        var viewModel = TimerViewModel()
        
        // act
        viewModel.start(Date.now)
        
        // assert
        #expect(viewModel.isActive)
    }
    
    @Test func itShouldReturn25RemainingMinutes_GivenAskedForRemainingMinutesAtStartTime() async throws {
        var viewModel = TimerViewModel()
        let timeStamp = Date.now
        viewModel.start(timeStamp)
        
        // act
        let remainingTime = viewModel.remainingSeconds(at: timeStamp)
        
        //assert
        #expect(remainingTime == 25 * 60)
    }
    
    @Test func itShouldBeInactive_GivenStopped() async throws {
        var viewModel = TimerViewModel()
        viewModel.start(Date.now)
        
        viewModel.stop()
        
        #expect(!viewModel.isActive)
    }
}
