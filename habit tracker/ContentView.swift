//
//  ContentView.swift
//  habit tracker
//
//  Created by Jocelyn on 2024-01-02.
//

import SwiftUI

/*
 displays a list of habits, allows user to mark habits as completed
 
 MODIFIES: JSON object containing saved habits
 EFFECTS: displays habits in list and adds habits to list, modifies completion state of existing habits
 */
struct ContentView: View {
    @State var habit: Habit = Habit()
    
    @ObservedObject var habitTracker: HabitTracker = HabitTracker()
    
    var body: some View {
        NavigationStack {
            
            VStack {
                // display list of habits
                ScrollView (.vertical) {
                    ForEach(Array(habitTracker.habits.enumerated()), id: \.offset) {index, h in
                        Button(action: {
                            habitTracker.habits[index].completed.toggle()
                            if (habitTracker.habits[index].completed) {
                                habitTracker.habits[index].increaseTally()
                            } else {
                                habitTracker.habits[index].decreaseTally()
                            }
                            
//                            habits[index].
                        }) {
                            ZStack {
                                HStack {
                                    Text(h.type.rawValue)
                                    Text(h.title)
                                    Spacer()
                                    Text(h.frequency.rawValue)
                                        .italic()
                                    Text("Completed percent: \(Double(h.tally) / Double(h.goal))")
                                }
                                .contentShape(Rectangle())
                                .padding()
                                
                                .background(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 25)
                                        .trim(from: 0.5 - (Double(h.tally) / Double(h.goal)) / 2, to: 0.5 + (Double(h.tally) / Double(h.goal)) / 2)
                                        .fill(h.completed ? Color.green : Color.red)
                                        .opacity(0.5)

                                }
                                
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .strokeBorder(h.completed ? Color.green : Color.red)
                                )
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                Spacer()
                
                // allow user to add a habit
                HStack {
                    Picker("Select Activity", selection: $habit.type) {
                        ForEach(ActivityType.allCases, id: \.self) {
                            activity in Text(activity.rawValue)
                        }
                    }
                    TextField("Habit Name", text: $habit.title)
                    Picker("Select Frequency", selection: $habit.frequency) {
                        ForEach(Frequency.allCases, id: \.self) {
                            frequency in Text(frequency.rawValue)
                        }
                    }
                }
                Button(action: {
                    habitTracker.addHabit(h: habit)
                }) {
                        Text("Add Habit")
                }
            }
            
            .navigationTitle("Habits")
            .padding([.bottom, .leading, .trailing])
        }
    }
}

#Preview {
    ContentView()
}
