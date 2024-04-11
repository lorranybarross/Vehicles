//
//  AlphabetScrollView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 06/04/24.
//

import SwiftUI

struct AlphabetFilterScrollView: View {
    
    // MARK: - Attributes
    let alphabet: [String]
    var onLetterTap: (String) -> Void
    
    // MARK: - View
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(alphabet, id: \.self) { letter in
                    Button {
                        onLetterTap(letter)
                    } label: {
                        Text(letter)
                            .foregroundStyle(.accent)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(.textSecondary.opacity(0.1))
                            .clipShape(.rect(cornerRadius: 5))
                    }
                }
            }
        }
    }
}
