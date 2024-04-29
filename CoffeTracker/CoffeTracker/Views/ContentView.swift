//
//  ContentView.swift
//  CoffeTracker
//
//  Created by Mohammad Dawoud on 2024-04-09.
//

import SwiftUI

struct ContentView: View {
    @StateObject var menu = Menu()
    @StateObject var history = History()
    @State private var showingAddScreen = false
    
    var totalCaffeine : Int {
        history.servings.map(\.caffeine).reduce(0, +)
    }
    var totalCalories : Int {
        history.servings.map(\.calories).reduce(0, +)
    }
    
    var body: some View {
        NavigationView {
            List {
                if history.servings.isEmpty {
                    Button("Add new drink") {
                        showingAddScreen = true
                    }
                } else {
                    Section("Summary") {
                        Text("Total Caffeine: \(totalCaffeine)mg")
                        Text("Total Calories: \(totalCalories)")
                    }
                    
                    ForEach(history.servings) { serving in
                        NavigationLink {
                            SingleServeView(serving: serving)
                        } label: {
                            VStack(alignment: .leading){
                                Text(serving.name)
                                    .font(.headline)
                                Text(serving.description)
                                    .font(.caption)
                            } //: VStack
                        }
                        .swipeActions {
                            Button("delete", systemImage: "trash", role: .destructive) {
                                withAnimation {
                                    history.delete(serving)
                                }
                            }
                            Button("reorder", systemImage: "chevron.up") {
                                withAnimation {
                                    history.reorder(serving)
                                }
                            }
                            .tint(.blue)
                        }
                    }
                }
            } //: List
            .sheet(isPresented: $showingAddScreen, content: MenuView.init)
            .navigationTitle("Cool Beans")
            .toolbar {
                Button("Add New Drink", systemImage: "plus") {
                    showingAddScreen = true
                }
            }
        } //: NavigationView end
        .environmentObject(menu)
        .environmentObject(history)
    }
}

#Preview {
    ContentView()
}
