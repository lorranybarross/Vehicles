//
//  DisplayListView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 07/04/24.
//

import SwiftUI

struct DisplayListView: View {
    
    // MARK: - Attibutes
    let title: String
    let make: Make
    let models: [Model]?
    let years: [ModelYear]?
    let monthCode: String
    
    init(title: String, make: Make, models: [Model]? = nil, years: [ModelYear]? = nil, monthCode: String) {
        self.title = title
        self.make = make
        self.models = models
        self.years = years
        self.monthCode = monthCode
    }
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .bold()
            
            if let models {
                ForEach(models, id: \.code) { model in
                    NavigationLink {
                        SecondDetailView(title: title, make: make, model: model, monthCode: monthCode)
                    } label: {
                        TextList(model.name)
                    }
                }
            } else if let years {
                ForEach(years, id: \.code) { year in
                    NavigationLink {
                        SecondDetailView(title: title, make: make, year: year, monthCode: monthCode)
                    } label: {
                        TextList(year.yearNameWithZeroKM)
                    }
                }
            }
        }
    }
}

#Preview {
    DisplayListView(title: "Models", make: Make.makeMock, models: [Model.modelMock], monthCode: "308")
}

struct TextList: View {
    let text: String
        
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack {
            Text(text)
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.textPrimary)                
            
            Spacer()
            
            Image(systemName: "chevron.right")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.regularMaterial)
        .cornerRadius(10)
    }
}
