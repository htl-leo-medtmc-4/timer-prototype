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
        let remainingTime = timerViewModel.remainingSeconds(at: Date.now)
        
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
        let remainingTime = try #require(viewModel.remainingSeconds(at: timeStamp))
        
        //assert
        #expect(remainingTime.second == viewModel.defaultDuration)
    }
    
    @Test func itShouldBeInactive_GivenPaused() async throws {
        var viewModel = TimerViewModel()
        viewModel.start(Date.now)
        
        viewModel.pause()
        
        #expect(!viewModel.isActive)
    }
}
