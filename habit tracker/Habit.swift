//
//  Habit.swift
//  habit tracker
//
//  Created by Jocelyn on 2024-01-02.
//

import Foundation

// represents activity types
enum ActivityType: String, CaseIterable, Codable {
    case 💻, 📝, 📖, 🏃
}

// represents possible frequencies for habits
enum Frequency: String, CaseIterable, Codable {
    case Daily, Weekly, Monthly
}

// represents a habit with a type, title, frequency, completion state, and number of successful completions toward a goal
struct Habit: Identifiable, Hashable, Codable {
    var type: ActivityType = .📝
    var title: String = ""
    var frequency: Frequency = .Daily
    var completed: Bool = false
    var tally: Int = 3
    var goal: Int = 10
    
    private var goalMet: Bool = false
    var id: String { title }
    
    
    internal init(type: ActivityType = .📝, title: String = "", frequency: Frequency = .Daily, completed: Bool = false, tally: Int = 3, goal: Int = 10) {
        self.type = type
        self.title = title
        self.frequency = frequency
        self.completed = completed
        self.tally = tally
        self.goal = goal
        self.goalMet = false
    }
    
    func isGoalMet() -> Bool {
        return goalMet
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(title)
        hasher.combine(frequency)
        hasher.combine(completed)
        hasher.combine(goal)
        hasher.combine(tally)
    }
    
    // REQUIRES: intialized tally, completed, and goal
    // CHANGE: completed, tally
    // EFFECTS: handles moving from the end of one goal period to the next
    mutating func endOfHabitPeriod() {
        completed = false
    }
    
    // REQUIRES: intialized tally, completed, and goal
    // CHANGE: completed, tally
    // EFFECTS: changes the completion state of the habit and adjusts tally accordingly
    mutating func toggle() {
        completed.toggle()
        
        if (completed) {
           increaseTally()
        } else {
            decreaseTally()
        }
    }
    
    // REQUIRES: initialized tally and goal
    // CHANGE: tally
    // EFFECTS: increase tally by 1, and set goalMet to true if tally reaches goal
    mutating func increaseTally() -> Void {
        if (tally == Int.max) {
            return
        }
        
        tally += 1
        
        if (tally >= goal) {
            goalMet = true
        }
    }
    
    
    // REQUIRES: initialized tally and goal
    // CHANGE: tally
    // EFFECTS: decrease tally by 1 if greater than 0 otherwise set tally to 0, and mark goal as not met if tally changes to be less than goal
    mutating func decreaseTally() -> Void {
        if (tally <= 0) {
            tally = 0
            return
        }
        
        tally -= 1
        
        if (tally < goal) {
            goalMet = false
        }
    }
}

