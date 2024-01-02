//
//  Habit.swift
//  habit tracker
//
//  Created by Jocelyn on 2024-01-02.
//

import Foundation

// represents activity types
enum ActivityType: String, CaseIterable {
    case 💻, 📝, 📖, 🏃
}

// represents possible frequencies for habits
enum Frequency: String, CaseIterable {
    case Daily, Weekly, Monthly
}

// represents a habit with a type, title, frequency, completion state and id
struct Habit: Identifiable, Hashable {
    var type: ActivityType = .📝
    var title: String = ""
    var frequency: Frequency = .Daily
    var completed: Bool = false
    var id: String { title }
    
    // add codable functionality here
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(title)
        hasher.combine(frequency)
        hasher.combine(completed)
    }
}

