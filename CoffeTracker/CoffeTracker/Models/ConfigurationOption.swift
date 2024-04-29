//
//  ConfigurationOption.swift
//  CoffeTracker
//
//  Created by Mohammad Dawoud on 2024-04-10.
//

import Foundation

struct ConfigurationOption : Identifiable, Codable, Hashable {
    let id: UUID
    let name : String
    let calories : Int
    
    public static let none = ConfigurationOption(
        id: UUID(),
        name: "None",
        calories: 0
    )
}
