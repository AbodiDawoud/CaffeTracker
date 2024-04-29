//
//  Serving.swift
//  CoffeTracker
//
//  Created by Mohammad Dawoud on 2024-04-10.
//

import Foundation

struct Serving : Identifiable, Codable, Equatable {
    var id : UUID
    let name : String
    let description : String
    let caffeine : Int
    let calories : Int
}
