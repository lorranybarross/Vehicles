//
//  ListOfMakesView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 08/04/24.
//

import SwiftUI

struct ListOfMakesView: View {
    
    // MARK: - Attributes
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    let grid: Bool
    let makes: [Make]
    
    // MARK: - View
    var body: some View {
        ScrollView(showsIndicators: false) {
            if grid {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(makes, id: \.code) { make in
                        NavigationLink {
                            MakeDetailView(make: make)
                        } label: {
                            MakeCardView(make: make)
                        }
                    }
                }
            } else {
                ForEach(makes, id: \.code) { make in
                    NavigationLink {
                        MakeDetailView(make: make)
                    } label: {
                        MakeListView(make: make)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ListOfMakesView(grid: true, makes: [Make.makeMock])
}
