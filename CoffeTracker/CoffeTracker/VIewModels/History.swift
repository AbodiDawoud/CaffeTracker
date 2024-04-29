//
//  History.swift
//  CoffeTracker
//
//  Created by Mohammad Dawoud on 2024-04-10.
//

import Foundation

class History : ObservableObject {
    @Published var servings : [Serving]
    private let savePath = FileManager.ducomentsDirectory.appendingPathComponent("SavedDrinks")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            servings = try JSONDecoder().decode([Serving].self, from: data)
            
        } catch {
            servings = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(servings)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save the data")
        }
    }
    
    func add(
        _ drink: Drink,
        size: String,
        isDecaf: Bool,
        extraShots: Int,
        milk: ConfigurationOption,
        syrup: ConfigurationOption,
        calories: Int,
        caffeine: Int
    ) {
        var desc = [String]()
        desc.append(size)
        
        if isDecaf {
            desc.append("Decaffeinated")
        }
        
        switch extraShots {
        case 0: break
        case 1: desc.append("1 extra shot")
        default: desc.append("\(extraShots) extra shots")
        }
        
        if milk != .none {
            desc.append("\(milk.name.lowercased()) milk")
        }
        
        if syrup != .none {
            desc.append("\(syrup.name.lowercased()) syrup")
        }
        
        let descriptionString = desc.joined(separator: ", ")
        let serving = Serving(id: UUID(), name: drink.name, description: descriptionString, caffeine: caffeine, calories: calories)
        servings.insert(serving, at: 0)
        save()
    }
    
    func reorder(_ serving : Serving) {
        var copy = serving
        copy.id = UUID()
        servings.insert(copy, at: 0)
        delete(serving)
    }
    
    func delete(_ serving : Serving) {
        if let index = servings.firstIndex(of: serving) {
            servings.remove(at: index)
            save()
        }
    }
}
