//
//  LogoView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 11/04/24.
//

import SwiftUI

struct LogoView: View {
    
    let imageName: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding(5)
                .background(.white)
                .clipShape(.rect(cornerRadius: 10))
        }
    }
}

#Preview {
    LogoView(imageName: "Fiat")
}
