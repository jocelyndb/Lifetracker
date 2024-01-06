//
//  TestHabitTracker.swift
//  habit tracker
//
//  Created by Jocelyn on 2024-01-06.
//

import XCTest
//@testable import habit_tracker

final class TestHabitTracker: XCTestCase {
    
    var dailyStudy: Habit = Habit()
    var monthlyRun: Habit = Habit()

    var emptyHabitTracker: HabitTracker = HabitTracker()
    var oneHabitHabitTracker: HabitTracker = HabitTracker()
    var multipleHabitHabitTracker: HabitTracker = HabitTracker()
    
    
    override func setUpWithError() throws {
        // init habits
        dailyStudy = Habit(type: .📝, title: "Studying", frequency: .Daily, completed: false, tally: 0, goal: 10)
        monthlyRun = Habit(type: .🏃, title: "Running", frequency: .Monthly, completed: false, tally: 0, goal: 25)

        // init habitTrackers
        emptyHabitTracker = HabitTracker()
        
        oneHabitHabitTracker = HabitTracker()
        oneHabitHabitTracker.addHabit(h: dailyStudy)
        
        multipleHabitHabitTracker = HabitTracker()
        multipleHabitHabitTracker.addHabit(h: dailyStudy)
        multipleHabitHabitTracker.addHabit(h: monthlyRun)
    }

    override func tearDownWithError() throws {
        // non default destructor code goes here
    }
    
    func testHabitTrackerInitializer() throws {
        XCTAssert(emptyHabitTracker.habits.isEmpty)
    }
    
    
    func testAddHabitEmptyHabitTracker() throws {
        XCTAssert(emptyHabitTracker.habits.isEmpty)
        
        emptyHabitTracker.addHabit(h: dailyStudy)
        
        XCTAssertEqual(emptyHabitTracker.habits.count, 1)
        XCTAssert(emptyHabitTracker.habits.contains(dailyStudy))
    }
    
    func testAddHabitOneHabitHabitTracker() throws {
        XCTAssertEqual(oneHabitHabitTracker.habits.count, 1)
        XCTAssert(oneHabitHabitTracker.habits.contains(dailyStudy))
        
        oneHabitHabitTracker.addHabit(h: monthlyRun)
        
        XCTAssertEqual(oneHabitHabitTracker.habits.count, 2)
        XCTAssert(oneHabitHabitTracker.habits.contains(dailyStudy))
        XCTAssert(oneHabitHabitTracker.habits.contains(monthlyRun))
    }
    
    func testRemoveHabitFromEmptyHabitTracker() throws {
        XCTAssert(emptyHabitTracker.habits.isEmpty)

        do {
            try emptyHabitTracker.removeHabit(h: dailyStudy)
            XCTFail("Expected objectDoesNotExistError")
        } catch (DataError.objectDoesNotExistError) {
            // ensure no habits added
            XCTAssert(emptyHabitTracker.habits.isEmpty)
        }
    }
    
    func testRemoveHabitNotInTracker() throws {
        XCTAssertEqual(oneHabitHabitTracker.habits.count, 1)
        XCTAssert(oneHabitHabitTracker.habits.contains(dailyStudy))

        do {
            try oneHabitHabitTracker.removeHabit(h: monthlyRun)
            XCTFail("Expected objectDoesNotExistError")
        } catch (DataError.objectDoesNotExistError) {
            // ensure no habits were deleted
            XCTAssertEqual(oneHabitHabitTracker.habits.count, 1)
            XCTAssert(oneHabitHabitTracker.habits.contains(dailyStudy))
        }
    }
    
    func testRemoveHabitOneHabitHabitTrackerInTracker() throws {
        XCTAssertEqual(oneHabitHabitTracker.habits.count, 1)
        XCTAssert(oneHabitHabitTracker.habits.contains(dailyStudy))
        
        do {
            try oneHabitHabitTracker.removeHabit(h: dailyStudy)
            XCTAssert(oneHabitHabitTracker.habits.isEmpty)
        } catch (DataError.objectDoesNotExistError) {
            XCTFail("Unexpected objectDoesNotExistError")
        }
    }
    
    func testRemoveHabitMultipleHabitHabitTrackerFirstHabitInTracker() throws {
        XCTAssertEqual(multipleHabitHabitTracker.habits.count, 2)
        XCTAssert(multipleHabitHabitTracker.habits.contains(dailyStudy))
        XCTAssert(multipleHabitHabitTracker.habits.contains(monthlyRun))
        
        do {
            try multipleHabitHabitTracker.removeHabit(h: dailyStudy)
            XCTAssertEqual(multipleHabitHabitTracker.habits.count, 1)
            XCTAssert(multipleHabitHabitTracker.habits.contains(monthlyRun))
        } catch (DataError.objectDoesNotExistError) {
            XCTFail("Unexpected objectDoesNotExistError")
        }
    }
    
    func testRemoveHabitMultipleHabitHabitTrackerSecondHabitInTracker() throws {
        XCTAssertEqual(multipleHabitHabitTracker.habits.count, 2)
        XCTAssert(multipleHabitHabitTracker.habits.contains(dailyStudy))
        XCTAssert(multipleHabitHabitTracker.habits.contains(monthlyRun))
        
        do {
            try multipleHabitHabitTracker.removeHabit(h: monthlyRun)
            XCTAssertEqual(oneHabitHabitTracker.habits.count, 1)
            XCTAssert(oneHabitHabitTracker.habits.contains(dailyStudy))
        } catch (DataError.objectDoesNotExistError) {
            XCTFail("Unexpected objectDoesNotExistError")
        }
    }
}

