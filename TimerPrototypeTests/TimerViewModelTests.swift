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

    @Test func itShouldHaveStatusStopped_GivenConstructed() async throws {
        // arrange (and act)
        let timerViewModel = TimerViewModel()
        
        // assert
        #expect(timerViewModel.status == .stopped)
    }
    
    @Test func itShouldReturnNil_GivenAskedForRemainingTimeAndNotStarted() async throws {
        // arrange
        let timerViewModel = TimerViewModel()
        
        // act
        let remainingTime = timerViewModel.remainingTime(at: Date.now)
        
        // assert
        #expect(remainingTime == nil)
    }
    
    @Test func itShouldHaveStatusRunning_GivenStarted() async throws {
        // arrange
        let timerViewModel = TimerViewModel()
        
        // act
        timerViewModel.start(at: Date.now)
        
        // assert
        #expect(timerViewModel.status == .running)
    }
    
    @Test func itShouldReturn25RemainingMinutes_GivenDefaultTimeAndAskedForRemainingMinutesAtStartTime() async throws {
        let timerViewModel = TimerViewModel()
        let timeStamp = Date.now
        timerViewModel.start(at: timeStamp)
        
        // act
        let remainingTime = try #require(timerViewModel.remainingTime(at: timeStamp))
        
        //assert
        #expect(remainingTime.minute == timerViewModel.defaultDuration.minute)
    }
    
    @Test func itShouldReturnSpecificTimeRemaining_GivenDurationSpecifiedWhenConstructed() async throws {
        let startTime = Date.now
        let specificTime = (hours: 1, minutes: 5, seconds: 44)
        let timerViewModel = TimerViewModel(duration: specificTime)
        
        timerViewModel.start(at: startTime)
        let remainingTime = try #require(timerViewModel.remainingTime(at: startTime))
        
        #expect(remainingTime.hour == specificTime.hours)
        #expect(remainingTime.minute == specificTime.minutes)
        #expect(remainingTime.second == specificTime.seconds)
    }
    
    @Test func itShouldReturn24MinutesAnd59SecondsRemaining_GivenAskedForRemainingMinutesAfterOneSecond() async throws {
        let timerViewModel = TimerViewModel()
        let currentTime = Date.now
        timerViewModel.start(at: currentTime)
        
        let remainingTime = try #require(timerViewModel.remainingTime(at: currentTime.addingTimeInterval(1)))
        
        #expect(remainingTime.minute == 24)
        #expect(remainingTime.second == 59)
    }
    
    @Test func itShouldHaveStatusPaused_GivenPaused() async throws {
        let timerViewModel = TimerViewModel()
        timerViewModel.start(at: Date.now)
        timerViewModel.pause(at: Date.now)
        
        #expect(timerViewModel.status == .paused)
    }
    
    @Test func itShouldReturnTheRemainingTimeAtPause_GivenAskedForRemainingTimeAfterPaused() async throws {
        let timerViewModel = TimerViewModel()
        let startTime = Date.now
        timerViewModel.start(at: startTime)
        timerViewModel.pause(at: startTime.addingTimeInterval(30))
        
        let remainingTime = try #require(timerViewModel.remainingTime(at: startTime.addingTimeInterval(31)), "Remaining time should not be nil")
        
        #expect(remainingTime.minute == 24)
        #expect(remainingTime.second == 30)
    }
    
    @Test func itShouldHaveStatusStopped_GivenReset() async throws {
        let timerViewModel = TimerViewModel()
        timerViewModel.start(at: Date.now)
        timerViewModel.reset(at: Date.now)
        
        #expect(timerViewModel.status == .stopped)
    }
    
    @Test func itShouldReturnNilRemainingTime_GivenTimerIsReset() async throws {
        let timerViewModel = TimerViewModel()
        timerViewModel.start(at: Date.now)
        timerViewModel.reset(at: Date.now)
        
        let remainingTime = timerViewModel.remainingTime(at: Date.now)
        #expect(remainingTime == nil)
    }
    
    @Test func itShouldStartCountingDown_GivenTimerIsRestarted() async throws {
        let timerViewModel = TimerViewModel()
        let startTime = Date.now
        let pauseTime = startTime.addingTimeInterval(30)
        let resetTime = pauseTime.addingTimeInterval(30)
        timerViewModel.start(at: startTime)
        timerViewModel.pause(at: pauseTime)
        timerViewModel.reset(at: resetTime)
        
        let newStartTime = resetTime.addingTimeInterval(10)
        timerViewModel.start(at: newStartTime)
        
        #expect(timerViewModel.status == .running)
        let remainingTime = try #require(timerViewModel.remainingTime(at: newStartTime.addingTimeInterval(10)))
        #expect(remainingTime.minute == 24)
        #expect(remainingTime.second == 50)
    }
    
    @Test func itShouldContinueCountingDown_GivenTimerIsResumed() async throws {
        let timerViewModel = TimerViewModel()
        let startTime = Date.now
        let pauseTime = startTime.addingTimeInterval(30)
        let resumeTime = pauseTime.addingTimeInterval(10)
        
        timerViewModel.start(at: startTime)
        timerViewModel.pause(at: pauseTime)
        timerViewModel.resume(at: resumeTime)
        
        #expect(timerViewModel.status == .running)
        
        let remainingTime = try #require(timerViewModel.remainingTime(at: resumeTime.addingTimeInterval(10)))
        #expect(remainingTime.minute == 24)
        #expect(remainingTime.second == 20)
    }
}
