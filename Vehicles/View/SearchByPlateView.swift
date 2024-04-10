//
//  SearchByPlateView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 10/04/24.
//

import SwiftUI

struct SearchByPlateView: View {
    
    @State private var plate = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundSecondary
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    VStack {
                        ZStack {
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 100)
                                .foregroundStyle(.white)
                            
                            VStack(spacing: 0) {
                                ZStack {
                                    Rectangle()
                                        .frame(maxWidth: .infinity, maxHeight: 30)
                                        .foregroundStyle(.accent)
                                    HStack {
                                        Text("🇧🇷")
                                            .foregroundStyle(.clear)
                                        
                                        Spacer()
                                        
                                        Text("BRASIL")
                                            .font(.headline)
                                        
                                        Spacer()
                                        
                                        Text("🇧🇷")
                                    }
                                    .padding(.horizontal)
                                }
                                
                                TextField("", text: $plate,
                                          prompt: Text("AAA0A00")
                                    .foregroundStyle(.black.opacity(0.5))
                                )
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity, maxHeight: 70)
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .padding()
                                    .background(.white)
                                    .onChange(of: plate) { _, text in
                                        plate = String(text.prefix(7))
                                        let filtered = filterPlate(plate: text.uppercased())
                                        if plate != filtered {
                                            plate = filtered
                                        }
                                    }
                            }
                        }
                    }
                    
                    Button("GET FIPE") {
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.accent)
                    .foregroundStyle(.white)
                    .font(.title2)
                    .bold()
                }
                .padding()
            }
        }
    }
    
    func filterPlate(plate: String) -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let numbers = "0123456789"
        
        var result = ""
        for (index, char) in plate.enumerated() {
            switch index {
            case 0...2:
                if letters.contains(char) {
                    result.append(char)
                }
            case 3:
                if numbers.contains(char) {
                    result.append(char)
                }
            case 4:
                if "ABCDEFGHIJ".contains(char) {
                    result.append(char)
                }
            case 5...6:
                if numbers.contains(char) {
                    result.append(char)
                }
            default:
                break
            }
        }
        
        return result
    }
}

#Preview {
    SearchByPlateView()
}
