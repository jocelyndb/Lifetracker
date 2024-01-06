//
//  HabitTracker.swift
//  habit tracker
//
//  Created by Jocelyn on 2024-01-02.
//

import Foundation

// represents a habit tracker, which tracks a list of habits and whether they are completed at specified frequencies
class HabitTracker: ObservableObject {
//    var date: Date =
    @Published var habits: [Habit] = []
    
    // stub
    // REQUIRES: initialized habits array
    // CHANGE: habits
    // EFFECTS: adds a habit to habits
    func addHabit(h: Habit) -> Void {
        habits.append(h)
    }
    
    // stub
    // REQUIRES: initialized habits array
    // CHANGE: habits
    // EFFECTS: removes h from habits or throws objectDoesNotExistError if h is not in habits
    func removeHabit(h: Habit) throws -> Void {
        // make sure the habit is in habits
        guard let habitIndex = habits.firstIndex(of: h) else {
            throw DataError.objectDoesNotExistError
        }
        
        habits.remove(at: habitIndex)
    }
}
