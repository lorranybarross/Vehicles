//
//  TextList.swift
//  Vehicles
//
//  Created by Lorrany Barros on 11/04/24.
//

import SwiftUI

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
            
            Spacer()
            
            Image(systemName: "chevron.right")
        }
        .padding()
        .foregroundStyle(.textPrimary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.regularMaterial)
        .cornerRadius(10)
    }
}

#Preview {
    TextList("Models")
}
