//
//  ListOfModelsOrYearsView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 07/04/24.
//

import SwiftUI

struct ListOfModelsOrYearsView: View {
    
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
    
    // MARK: - Main View
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .bold()
            
            showModels
            showYears
        }
    }
    
    // MARK: - Other Views
    var showModels: some View {
        VStack {
            if let models {
                ForEach(models, id: \.code) { model in
                    NavigationLink {
                        SecondDetailView(title: title, make: make, model: model, monthCode: monthCode)
                    } label: {
                        TextList(model.name)
                    }
                }
            }
        }
    }
    
    var showYears: some View {
        VStack {
            if let years {
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
    ListOfModelsOrYearsView(title: "Models", make: Make.makeMock, models: [Model.modelMock], monthCode: "308")
}
