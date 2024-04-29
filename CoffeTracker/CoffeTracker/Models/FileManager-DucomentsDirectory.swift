//
//  FileManager-DucomentsDirectory.swift
//  CoffeTracker
//
//  Created by Mohammad Dawoud on 2024-04-10.
//

import Foundation

extension FileManager {
    static var ducomentsDirectory : URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
