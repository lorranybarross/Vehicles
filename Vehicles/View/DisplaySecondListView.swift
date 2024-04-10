//
//  DisplaySecondListView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 09/04/24.
//

import SwiftUI

struct DisplaySecondListView: View {
    
    // MARK: - Attibutes
    let title: String
    let make: Make
    let model: Model?
    let year: ModelYear?
    let monthCode: String
    let models: [Model]?
    let years: [ModelYear]?
    
    init(title: String, make: Make, model: Model? = nil, year: ModelYear? = nil, monthCode: String, models: [Model]? = nil, years: [ModelYear]? = nil) {
        self.title = title
        self.make = make
        self.model = model
        self.year = year
        self.monthCode = monthCode
        self.models = models
        self.years = years
    }
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(title)
                .font(.title2)
                .bold()
            
            if let models, let year {
                ForEach(models, id: \.code) { item in
                    NavigationLink {
                        FipeView(make: make, model: item, year: year, monthCode: monthCode)
                    } label: {
                        TextList(item.name)
                    }
                }
            } else if let years, let model {
                ForEach(years, id: \.code) { item in
                    NavigationLink {
                        FipeView(make: make, model: model, year: item, monthCode: monthCode)
                    } label: {
                        TextList(item.yearNameWithZeroKM)
                    }
                }
            }
        }
    }
}

#Preview {
    DisplaySecondListView(title: "Models", make: Make.makeMock, monthCode: "308", models: [Model.modelMock])
}
