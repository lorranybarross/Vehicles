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
    
    // MARK: - Main View
    var body: some View {
        ScrollView(showsIndicators: false) {
            if makes.isEmpty {
                Text("No data available")
            } else {
                showView
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Other Views
    var gridView: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(makes, id: \.code) { make in
                NavigationLink {
                    MakeDetailView(make: make)
                } label: {
                    MakeCardView(make: make)
                }
            }
        }
    }
    
    var listView: some View {
        ForEach(makes, id: \.code) { make in
            NavigationLink {
                MakeDetailView(make: make)
            } label: {
                MakeListView(make: make)
            }
        }
    }
    
    var showView: some View {
        switch grid {
        case true:
            return AnyView(gridView)
        default:
            return AnyView(listView)
        }
    }
}

#Preview {
    ListOfMakesView(grid: true, makes: [Make.makeMock])
}
