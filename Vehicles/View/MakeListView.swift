//
//  MakeListView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 09/04/24.
//

import SwiftUI

struct MakeListView: View {
    
    // MARK: - Attributes
    let make: Make
    
    @State private var colors = Colors.colors.map { $0.color }
    
    // MARK: - Main View
    var body: some View {
        let color = colors[Int(make.code)! % colors.count]
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 5)
                .foregroundStyle(color)
                .padding(.vertical, -55)
            
            VStack {
                showCardView
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 30)
        .font(.title3)
        .multilineTextAlignment(.leading)
        .bold()
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 10))
    }
    
    // MARK: - Other Views
    var textView: some View {
        HStack {
            Text(make.name).tag(make.code)
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
    
    var showCardView: some View {
        HStack {
            LogoView(imageName:
                        "\(make.name.filter { $0.isLetter || $0.isNumber || $0.isWhitespace })")
            textView
        }
        .foregroundStyle(.textPrimary)
        .padding()
    }
}

#Preview {
    MakeListView(make: Make.makeMock)
}
