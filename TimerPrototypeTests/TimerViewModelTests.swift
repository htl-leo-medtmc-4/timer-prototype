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
    
    @Test func itShouldReturnNil_GivenAskedForRemainingTimeAndNotStarted() async throws {
        // arrange
        let timerViewModel = TimerViewModel()
        
        // act
        let remainingTime = timerViewModel.remainingTime(at: Date.now)
        
        // assert
        #expect(remainingTime == nil)
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
        let remainingTime = try #require(viewModel.remainingTime(at: timeStamp))
        
        //assert
        #expect(remainingTime.minute == viewModel.defaultDuration.minute)
    }
    
    @Test func itShouldReturn24MinutesAnd59SecondsRemaining_GivenAskedForRemainingMinutesAfterOneSecond() async throws {
        var timerViewModel = TimerViewModel()
        let currentTime = Date.now
        timerViewModel.start(currentTime)
        
        let remainingTime = try #require(timerViewModel.remainingTime(at: currentTime.addingTimeInterval(1)))
        
        #expect(remainingTime.minute == 24)
        #expect(remainingTime.second == 59)
    }
    
    @Test func itShouldBeInactive_GivenPaused() async throws {
        var viewModel = TimerViewModel()
        viewModel.start(Date.now)
        
        viewModel.pause()
        
        #expect(!viewModel.isActive)
    }
    
    @Test(.disabled("Do not turn off the remaining time even when paused")) func itShouldReturnTheRemainingTimeAtPause_GivenAskedForRemainingTimeAfterPaused() async throws {
        
    }
    
    @Test(.disabled("Reset the timer: inactive and remainingtime should be nil"))
    func itShouldBeInactive_GivenTimerIsReset() async throws {
        
    }
}
