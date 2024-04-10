//
//  MakeCardView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 05/04/24.
//

import SwiftUI

struct MakeCardView: View {
    
    let make: Make
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var colors = Colors.colors.map { $0.color }
    
    var body: some View {
        let color = colors[Int(make.code)! % colors.count]
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 5)
                .foregroundStyle(color)
                .padding(.vertical, -85)
            
            HStack {
                VStack(alignment: .leading) {
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
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.title3)
                        .multilineTextAlignment(.leading)
                        .bold()
                        .padding(.top, 5)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.textPrimary)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: 90)
        .padding(.vertical, 40)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    MakeCardView(make: Make.makeMock)
}
