//
//  MenuView.swift
//  CoffeTracker
//
//  Created by Mohammad Dawoud on 2024-04-09.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var menu : Menu
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    private let columns = [ GridItem(.adaptive(minimum: 150)) ]
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, pinnedViews: .sectionHeaders) {
                    ForEach(menu.sections) { section in
                        Section {
                            ForEach (section.matches(for: searchText)) { drink in
                                NavigationLink {
                                    CustomizeView(drink: drink) {
                                        dismiss()
                                    }
                                } label: {
                                    VStack {
                                        Image(drink.image)
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                        Text(drink.name)
                                            .font(.system(.body, design: .rounded))
                                    } //: VStack
                                    .padding(.bottom)
                                } //: NavigationLink end
                                .buttonStyle(.plain)
                            }
                        } header: {
                            Text(section.name)
                                .font(.system(.title, design: .rounded))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(5)
                                .background(.background)
                        }
                        
                    }
                } //: Lazy VGrid
                .padding(.horizontal)
                
            } //: ScrollView
            .navigationTitle("Add Drink")
            .searchable(text: $searchText)
        } //: NavigationStack
    }
}

#Preview {
    MenuView()
        .environmentObject(Menu())
}
