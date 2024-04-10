//
//  MakeListView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 09/04/24.
//

import SwiftUI

struct MakeListView: View {
    
    let make: Make
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var colors = Colors.colors.map { $0.color }
    
    var body: some View {
        let color = colors[Int(make.code)! % colors.count]
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 5)
                .foregroundStyle(color)
                .padding(.vertical, -55)
            
            HStack {
                var name = make.name
                Image("\(name.filter { $0.isLetter || $0.isNumber || $0.isWhitespace })")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding(5)
                    .background(.textPrimary)
                    .clipShape(.rect(cornerRadius: 10))
                
                Text(make.name).tag(make.code)
                    .foregroundStyle(.textPrimary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.textPrimary)
            }
            .padding()
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
}

#Preview {
    MakeListView(make: Make.makeMock)
}
