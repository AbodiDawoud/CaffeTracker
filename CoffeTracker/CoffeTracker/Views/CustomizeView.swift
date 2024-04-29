//
//  CustomizeView.swift
//  CoffeTracker
//
//  Created by Mohammad Dawoud on 2024-04-10.
//

import SwiftUI

struct CustomizeView: View {
    let drink : Drink
    @EnvironmentObject var menu : Menu
    @EnvironmentObject var history : History
    
    @State private var size = 0
    @State private var isDecaf = false
    @State private var extraShots = 0
    @State private var milk = ConfigurationOption.none
    @State private var syrup = ConfigurationOption.none
    @State private var isFirstAppearance = true
    
    let sizeOptions = ["Small", "Medium", "Large"]
    let dismiss : () -> Void
    
    var caffeine : Int {
        var caffeineAmout = drink.caffeine[size]
        caffeineAmout += (extraShots * 60)
        if isDecaf {
            caffeineAmout /= 20
        }
        return caffeineAmout
    }
    var calories : Int {
        var caloriesAmount = drink.baseCalories
        caloriesAmount += extraShots * 10
        if drink.coffeeBased {
            caloriesAmount += milk.calories
        } else {
            caloriesAmount += milk.calories / 8
        }
        caloriesAmount += syrup.calories
        return caloriesAmount * (size + 1)
    }
    
    
    var body: some View {
        Form{
            Section("Basic Options") {
                Picker("Size", selection: $size) {
                    ForEach(sizeOptions.indices) { index in
                        Text(sizeOptions[index])
                    }
                }
                .pickerStyle(.segmented)
                if drink.coffeeBased {
                    Stepper("Extra shots: \(extraShots)", value: $extraShots, in: 0...8)
                }
                Toggle("Decaffeinated", isOn: $isDecaf)
            } //: Section one
            
            
            Section("Customizations") {
                Picker("Milk", selection: $milk){
                    ForEach(menu.milkOptions) { option in
                        Text(option.name)
                            .tag(option)
                    }
                }
                if drink.coffeeBased {
                    Picker("Syrup", selection: $syrup){
                        ForEach(menu.syrupOptions) { option in
                            Text(option.name)
                                .tag(option)
                        }
                    }
                }
            } //: Section two

            
            Section("Estimates") {
                Text("**Caffeine:** \(caffeine)mg")
                Text("**Calories:** \(calories)")
            } //: Section three
            
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(drink.name)
        .toolbar {
            Button("Save") {
                history.add(
                    drink,
                    size: sizeOptions[size],
                    isDecaf: isDecaf,
                    extraShots: extraShots,
                    milk: milk,
                    syrup: syrup,
                    calories: calories,
                    caffeine: caffeine
                )
                dismiss()
            }
        } //: Toolbar end
        .onAppear {
            guard isFirstAppearance else { return }
            if drink.servedWithMilk {
                milk = menu.milkOptions[1]
            }
            isFirstAppearance = false
        }
    }
}

#Preview {
    CustomizeView(drink: Drink.example) {}
        .environmentObject(Menu())
}
