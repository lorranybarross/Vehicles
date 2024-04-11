//
//  FilterView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 06/04/24.
//

import SwiftUI

struct FilterView: View {
    
    let make: Make
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var years = [ModelYear]()
    @State private var minYear = 0.0
    @State private var maxYear = 0.0
    @State private var isEditingMinYear = false
    
    var minYearPossible: Double {
        let yearsAux = years.compactMap { year -> Double? in
            guard let yearString = year.name.split(separator: " ").first else { return nil }
            return Double(yearString)
        }
        
        return yearsAux.min() ?? 0
    }
    
    var maxYearPossible: (Double, Bool) {
        let yearsAux = years.compactMap { year -> Double? in
            guard let yearString = year.name.split(separator: " ").first else { return nil }
            return Double(yearString)
        }
        
        if yearsAux.contains(32000), yearsAux.filter({ $0 == 32000 }).count > 1 {
            let filteredYears = yearsAux.filter { $0 != 32000 }
            return (filteredYears.max() ?? 0, true)
        } /*else if let maxYear = yearsAux.max(), maxYear != 32000 {
            return (maxYear, false)
        }*/ else {
            return (maxYear, false)
        }
    }
    
    func convertStringToYear(year: Double) -> String {
        return String(Int(year))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                Text("Filters")
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Label("Dismiss", systemImage: "xmark")
                        .font(.title2)
                        .labelStyle(.iconOnly)
                        .tint(.accent)
                }
            }
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Min year")
                    .font(.title3)
                    .bold()
                
                Text("The minimum year for \(make.name) is \(convertStringToYear(year: minYearPossible))")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                            
                Slider(
                    value: $minYear,
                    in: minYearPossible...(maxYearPossible.0 + 1),
                    step: 1
                ) {
                    Text("Year")
                } minimumValueLabel: {
                    Text("\(convertStringToYear(year: minYearPossible))")
                } maximumValueLabel: {
                    Text("Zero KM")
                }
                
                if minYear == maxYearPossible.0 + 1 {
                    Text("Selected min year: Zero KM")
                        .font(.headline)
                } else {
                    Text("Selected min year: \(convertStringToYear(year: minYear))")
                        .font(.headline)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Max year")
                    .font(.title3)
                    .bold()
                
                Text("The maximum year for \(make.name) is \(convertStringToYear(year: maxYearPossible.0))")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                            
                Slider(
                    value: $minYear,
                    in: minYearPossible...(maxYearPossible.0 + 1),
                    step: 1
                ) {
                    Text("Year")
                } minimumValueLabel: {
                    Text("\(convertStringToYear(year: minYearPossible))")
                } maximumValueLabel: {
                    Text("Zero KM")
                }
                
                if minYear == maxYearPossible.0 + 1 {
                    Text("Selected min year: Zero KM")
                        .font(.headline)
                } else {
                    Text("Selected min year: \(convertStringToYear(year: minYear))")
                        .font(.headline)
                }
            }
            
            Text("Fuel")
                .font(.title3)
            
            Spacer()
        }
        .padding()
        .onAppear {
            
        }
    }
}

#Preview {
    FilterView(make: Make.makeMock)
}
