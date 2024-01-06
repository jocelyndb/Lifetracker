//
//  TestHabit.swift
//  habit trackerTests
//
//  Created by Jocelyn on 2024-01-07.
//

import XCTest

final class TestHabit: XCTestCase {
    var dailyStudy: Habit = Habit()
    var monthlyRun: Habit = Habit()
    var weeklyComputer: Habit = Habit()
    var weeklyComputerGoalMet: Habit = Habit()
    var weeklyComputerMaxTally: Habit = Habit()
    var weeklyComputerTallyOneAboveGoal: Habit = Habit()
    var weeklyComputerNegativeTally: Habit = Habit()

    override func setUpWithError() throws {
        dailyStudy = Habit(type: .📝, title: "Studying", frequency: .Daily, completed: false, tally: 0, goal: 10)
        monthlyRun = Habit(type: .🏃, title: "Running", frequency: .Monthly, completed: true, tally: 3, goal: 25)
        weeklyComputer = Habit(type: .💻, title: "Computing", frequency: .Weekly, completed: false, tally: 9, goal: 10)
        weeklyComputerGoalMet = Habit(type: .💻, title: "Computing", frequency: .Weekly, completed: false, tally: 10, goal: 10)
        weeklyComputerMaxTally = Habit(type: .💻, title: "Computing", frequency: .Weekly, completed: true, tally: Int.max, goal: 10)
        weeklyComputerTallyOneAboveGoal = Habit(type: .💻, title: "Computing", frequency: .Weekly, completed: false, tally: 11, goal: 10)
        weeklyComputerNegativeTally = Habit(type: .💻, title: "Computing", frequency: .Weekly, completed: false, tally: -1, goal: 10)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitializer() {
        XCTAssertEqual(dailyStudy.type, ActivityType.📝)
        XCTAssertEqual(dailyStudy.title, "Studying")
        XCTAssertEqual(dailyStudy.frequency, Frequency.Daily)
        XCTAssertEqual(dailyStudy.completed, false)
        XCTAssertEqual(dailyStudy.tally, 0)
        XCTAssertEqual(dailyStudy.goal, 10)
        XCTAssertEqual(dailyStudy.isGoalMet(), false)
        
        XCTAssertEqual(monthlyRun.type, ActivityType.🏃)
        XCTAssertEqual(monthlyRun.title, "Running")
        XCTAssertEqual(monthlyRun.frequency, Frequency.Monthly)
        XCTAssertEqual(monthlyRun.completed, true)
        XCTAssertEqual(monthlyRun.tally, 3)
        XCTAssertEqual(monthlyRun.goal, 25)
        XCTAssertEqual(monthlyRun.isGoalMet(), false)
    }
    
    func testEndOfHabitPeriodNotCompleted() {
        XCTAssertFalse(dailyStudy.completed)
        XCTAssertEqual(dailyStudy.tally, 0)

        dailyStudy.endOfHabitPeriod()
        
        XCTAssertFalse(dailyStudy.completed)
        XCTAssertEqual(dailyStudy.tally, 0)
    }

    func testEndOfHabitPeriodCompleted() {
        XCTAssert(monthlyRun.completed)
        XCTAssertEqual(monthlyRun.tally, 3)
        
        monthlyRun.endOfHabitPeriod()
        
        XCTAssertFalse(monthlyRun.completed)
        XCTAssertEqual(monthlyRun.tally, 3)

    }
    
    func testToggleNotCompleted() {
        XCTAssertFalse(dailyStudy.completed)
        XCTAssertEqual(dailyStudy.tally, 0)
        
        dailyStudy.toggle()
        
        XCTAssert(dailyStudy.completed)
        XCTAssertEqual(dailyStudy.tally, 1)
    }
    
    func testToggleCompleted() {
        XCTAssert(monthlyRun.completed)
        XCTAssertEqual(monthlyRun.tally, 3)
        
        monthlyRun.toggle()
        
        XCTAssertFalse(monthlyRun.completed)
        XCTAssertEqual(monthlyRun.tally, 2)
    }
    
    func testIncreaseTally() {
        XCTAssertEqual(monthlyRun.tally, 3)
        XCTAssertFalse(monthlyRun.isGoalMet())
        
        monthlyRun.increaseTally()
        
        XCTAssertEqual(monthlyRun.tally, 4)
        XCTAssertFalse(monthlyRun.isGoalMet())
    }
    
    func testIncreaseTallyOneLessThanGoal() {
        XCTAssertEqual(weeklyComputer.tally, 9)
        XCTAssertFalse(weeklyComputer.isGoalMet())
        
        weeklyComputer.increaseTally()
        
        XCTAssertEqual(weeklyComputer.tally, 10)
        XCTAssert(weeklyComputer.isGoalMet())
    }
    
    func testIncreaseTallyAtGoal() {
        XCTAssertEqual(weeklyComputerGoalMet.tally, 10)
        
        // make habit set goalMet = true
        weeklyComputerGoalMet.toggle()
        weeklyComputerGoalMet.toggle()
        
        XCTAssert(weeklyComputerGoalMet.isGoalMet())
        
        weeklyComputerGoalMet.increaseTally()
        
        XCTAssertEqual(weeklyComputerGoalMet.tally, 11)
        XCTAssert(weeklyComputerGoalMet.isGoalMet())
    }
    
    func testIncreaseTallyMaxTally() {
        XCTAssertEqual(weeklyComputerMaxTally.tally, Int.max)
        
        // make habit set goalMet = true
        weeklyComputerMaxTally.toggle()
        weeklyComputerMaxTally.toggle()
        
        XCTAssert(weeklyComputerMaxTally.isGoalMet())
        
        weeklyComputerMaxTally.increaseTally()
        
        XCTAssertEqual(weeklyComputerMaxTally.tally, Int.max)
        XCTAssert(weeklyComputerMaxTally.isGoalMet())
    }
    
    func testDecreaseTally() {
        XCTAssertEqual(monthlyRun.tally, 3)
        XCTAssertFalse(monthlyRun.isGoalMet())
        
        monthlyRun.decreaseTally()
        
        XCTAssertEqual(monthlyRun.tally, 2)
        XCTAssertFalse(monthlyRun.isGoalMet())
    }
    
    func testDecreaseTallyGoalMet() {
        XCTAssertEqual(weeklyComputerGoalMet.tally, 10)
        
        // make habit set goalMet = true
        weeklyComputerGoalMet.toggle()
        weeklyComputerGoalMet.toggle()
        
        XCTAssert(weeklyComputerGoalMet.isGoalMet())
        
        weeklyComputerGoalMet.decreaseTally()
        
        XCTAssertEqual(weeklyComputerGoalMet.tally, 9)
        XCTAssertFalse(weeklyComputerGoalMet.isGoalMet())
    }
    
    func testDecreaseTallyOneAboveGoal() {
        XCTAssertEqual(weeklyComputerTallyOneAboveGoal.tally, 11)
        
        // make habit set goalMet = true
        weeklyComputerTallyOneAboveGoal.toggle()
        weeklyComputerTallyOneAboveGoal.toggle()
        
        XCTAssert(weeklyComputerTallyOneAboveGoal.isGoalMet())
        
        weeklyComputerTallyOneAboveGoal.decreaseTally()
        
        XCTAssertEqual(weeklyComputerTallyOneAboveGoal.tally, 10)
        XCTAssert(weeklyComputerTallyOneAboveGoal.isGoalMet())
    }
    
    func testDecreaseTallyZeroTally() {
        XCTAssertEqual(dailyStudy.tally, 0)
        XCTAssertFalse(dailyStudy.isGoalMet())
        
        dailyStudy.decreaseTally()
        
        XCTAssertEqual(dailyStudy.tally, 0)
        XCTAssertFalse(dailyStudy.isGoalMet())
    }
    
    func testDecreaseTallyNegativeTally() {
        XCTAssertEqual(weeklyComputerNegativeTally.tally, -1)
        XCTAssertFalse(weeklyComputerNegativeTally.isGoalMet())
        
        weeklyComputerNegativeTally.decreaseTally()
        
        XCTAssertEqual(weeklyComputerNegativeTally.tally, 0)
        XCTAssertFalse(weeklyComputerNegativeTally.isGoalMet())
    }
}
