//
//  SingleServeView.swift
//  CoffeTracker
//
//  Created by Mohammad Dawoud on 2024-04-11.
//

import SwiftUI

struct SingleServeView: View {
    var serving : Serving
    var imageName : String {
        serving.name.lowercased().replacingOccurrences(of: " ", with: "-")
    }
    
    var body: some View {
        Form {
            Section("About this drink") {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Text("**Drink:** \(serving.name)")
                Text("**Description:** \(serving.description)")
                Text("**Total caffeine:** \(serving.caffeine)")
                Text("**Total calories:** \(serving.calories)")
            }
        }
        .navigationTitle(serving.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SingleServeView(serving: Serving.init(id: UUID(), name: "Example", description: "Whatever", caffeine: 21, calories: 32))
}
