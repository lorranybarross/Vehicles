//
//  MakeCardView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 05/04/24.
//

import SwiftUI

struct MakeCardView: View {
    
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
                .padding(.vertical, -85)
            
            VStack {
                showListView
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 90)
        .padding(.vertical, 40)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 10))
    }
    
    // MARK: - Other Views
    var textView: some View {
        HStack {
            Text(make.name).tag(make.code)
                .foregroundStyle(.textPrimary)
                .fixedSize(horizontal: false, vertical: true)
                .font(.title3)
                .multilineTextAlignment(.leading)
                .bold()
                .padding(.top, 5)
        }
    }
    
    var showListView: some View {
        HStack {
            VStack(alignment: .leading) {
                LogoView(imageName:
                            "\(make.name.filter { $0.isLetter || $0.isNumber || $0.isWhitespace })")
                textView
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.textPrimary)
        }
        .padding()
    }
}

#Preview {
    MakeCardView(make: Make.makeMock)
}
