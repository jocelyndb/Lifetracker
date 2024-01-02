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
    
    @State var habits: [Habit] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                // display list of habits
                ScrollView (.vertical) {
                    ForEach(Array(habits.enumerated()), id: \.offset) {index, h in
//                        HStack {
//                            Text(h.type.rawValue)
//                            Text(h.title)
//                            Spacer()
//                            Text(h.frequency.rawValue)
//                                .italic()
//                        }
//                        
//                        .padding()
//                        
////                        .overlay(
////                            RoundedRectangle(cornerRadius: 25)
////                            .strokeBorder(h.completed ? Color.green : Color.red)
////                            .fill(Color.clear)
////
////                        )
////                        .background(h.completed ? Color.green : Color.red)
////                        .ignoresSafeArea()
//                        .onTapGesture {
//                            habits[index].completed.toggle()
//                        }
                        
                        Button(action: {
                            habits[index].completed.toggle()
                        }) {
                            HStack {
                                Text(h.type.rawValue)
                                Text(h.title)
                                Spacer()
                                Text(h.frequency.rawValue)
                                    .italic()
                            }
                            
                            .padding()
                            
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                .strokeBorder(h.completed ? Color.green : Color.red)
                            )

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
                    habits.append(habit)
                }) {
                        Text("Add Habit")
                }
            }
            
            .navigationTitle("Habits")
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
