//
//  Drink.swift
//  CoffeTracker
//
//  Created by Mohammad Dawoud on 2024-04-09.
//

import Foundation

struct Drink : Identifiable, Codable {
    let id: UUID
    let name : String
    let caffeine : [Int]
    let coffeeBased : Bool
    let servedWithMilk : Bool
    let baseCalories : Int
    var image : String {
        name.lowercased().replacingOccurrences(of: " ", with: "-")
    }
    
    
    static let example = Drink(
        id: UUID(),
        name: "Example drink",
        caffeine: [
            60,
            100,
            200
        ],
        coffeeBased: true,
        servedWithMilk: true,
        baseCalories: 60
    )
}
