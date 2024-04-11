//
//  AlphabetFilterScrollView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 06/04/24.
//

import SwiftUI

struct AlphabetFilterScrollView: View {
    
    // MARK: - Attributes
    @Binding var index: Int
    
    let alphabet: [String]
    var onLetterTap: (String) -> Void
    
    // MARK: - View
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(alphabet.indices, id: \.self) { index in
                    Button {
                        onLetterTap(alphabet[index])
                        self.index = index
                    } label: {
                        Text(alphabet[index])
                            .foregroundStyle(self.index == index ? .white : .accent)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(self.index == index ? .accent : .textSecondary.opacity(0.1))
                            .clipShape(.rect(cornerRadius: 5))
                    }
                }
            }
        }
    }
}
