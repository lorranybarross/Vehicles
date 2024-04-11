//
//  BackButtonView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 11/04/24.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button("Back", systemImage: "chevron.left") {
            dismiss()
        }
    }
}

#Preview {
    BackButtonView()
}
