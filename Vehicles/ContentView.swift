//
//  ContentView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 05/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
//            SearchByPlateView()
//                .tabItem {
//                    Label("Plate", systemImage: "licenseplate")
//                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    ContentView()
}
