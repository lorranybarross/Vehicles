//
//  InfoRowView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 11/04/24.
//

import SwiftUI

struct InfoRowView: View {
    var title: String
    var systemImage: String
    var detail: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Label(title, systemImage: systemImage)
                .font(.footnote)
            Text(detail)
        }
    }
}

#Preview {
    InfoRowView(title: "Model", systemImage: "car.fill", detail: "AMAROK High.CD 2.0 16V TDI 4x4 Dies. Aut")
}
