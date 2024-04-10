//
//  Colors.swift
//  Vehicles
//
//  Created by Lorrany Barros on 05/04/24.
//

import Foundation
import SwiftUI

struct CustomColor {
    var name: String
    var color: Color
}

struct Colors {
    static let colors: [CustomColor] = [
            CustomColor(name: "blueviolet", color: Color(red: 138/255, green: 43/255, blue: 226/255)),
            CustomColor(name: "cadetblue", color: Color(red: 95/255, green: 158/255, blue: 160/255)),
            CustomColor(name: "coral", color: Color(red: 255/255, green: 127/255, blue: 80/255)),
            CustomColor(name: "cornflowerblue", color: Color(red: 100/255, green: 149/255, blue: 237/255)),
            CustomColor(name: "crimson", color: Color(red: 220/255, green: 20/255, blue: 60/255)),
            CustomColor(name: "darkcyan", color: Color(red: 0/255, green: 139/255, blue: 139/255)),
            CustomColor(name: "darkgreen", color: Color(red: 0/255, green: 100/255, blue: 0/255)),
            CustomColor(name: "darkolivegreen", color: Color(red: 85/255, green: 107/255, blue: 47/255)),
            CustomColor(name: "darkorange", color: Color(red: 255/255, green: 140/255, blue: 0/255)),
            CustomColor(name: "darkorchid", color: Color(red: 153/255, green: 50/255, blue: 204/255)),
            CustomColor(name: "darkred", color: Color(red: 139/255, green: 0/255, blue: 0/255)),
            CustomColor(name: "darkseagreen", color: Color(red: 143/255, green: 188/255, blue: 143/255)),
            CustomColor(name: "darkslateblue", color: Color(red: 72/255, green: 61/255, blue: 139/255)),
            CustomColor(name: "darkslategray", color: Color(red: 47/255, green: 79/255, blue: 79/255)),
            CustomColor(name: "darkturquoise", color: Color(red: 0/255, green: 206/255, blue: 209/255)),
            CustomColor(name: "darkviolet", color: Color(red: 148/255, green: 0/255, blue: 211/255)),
            CustomColor(name: "deeppink", color: Color(red: 255/255, green: 20/255, blue: 147/255)),
            CustomColor(name: "deepskyblue", color: Color(red: 0/255, green: 191/255, blue: 255/255)),
            CustomColor(name: "dodgerblue", color: Color(red: 30/255, green: 144/255, blue: 255/255)),
            CustomColor(name: "firebrick", color: Color(red: 178/255, green: 34/255, blue: 34/255)),
            CustomColor(name: "forestgreen", color: Color(red: 34/255, green: 139/255, blue: 34/255)),
            CustomColor(name: "gold", color: Color(red: 255/255, green: 215/255, blue: 0/255)),
            CustomColor(name: "goldenrod", color: Color(red: 218/255, green: 165/255, blue: 32/255)),
            CustomColor(name: "gray", color: Color(red: 128/255, green: 128/255, blue: 128/255)),
            CustomColor(name: "green", color: Color(red: 0/255, green: 128/255, blue: 0/255)),
            CustomColor(name: "hotpink", color: Color(red: 255/255, green: 105/255, blue: 180/255)),
            CustomColor(name: "indianred", color: Color(red: 205/255, green: 92/255, blue: 92/255)),
            CustomColor(name: "indigo", color: Color(red: 75/255, green: 0/255, blue: 130/255)),
            CustomColor(name: "lightblue", color: Color(red: 173/255, green: 216/255, blue: 230/255)),
            CustomColor(name: "lightcoral", color: Color(red: 240/255, green: 128/255, blue: 128/255)),
            CustomColor(name: "lightgreen", color: Color(red: 144/255, green: 238/255, blue: 144/255)),
            CustomColor(name: "lightsalmon", color: Color(red: 255/255, green: 160/255, blue: 122/255)),
            CustomColor(name: "lightseagreen", color: Color(red: 32/255, green: 178/255, blue: 170/255)),
            CustomColor(name: "lightskyblue", color: Color(red: 135/255, green: 206/255, blue: 250/255)),
            CustomColor(name: "lightslategray", color: Color(red: 119/255, green: 136/255, blue: 153/255)),
            CustomColor(name: "lightsteelblue", color: Color(red: 176/255, green: 196/255, blue: 222/255)),
            CustomColor(name: "limegreen", color: Color(red: 50/255, green: 205/255, blue: 50/255)),
            CustomColor(name: "maroon", color: Color(red: 128/255, green: 0/255, blue: 0/255)),
            CustomColor(name: "mediumaquamarine", color: Color(red: 102/255, green: 205/255, blue: 170/255)),
            CustomColor(name: "mediumblue", color: Color(red: 0/255, green: 0/255, blue: 205/255)),
            CustomColor(name: "mediumorchid", color: Color(red: 186/255, green: 85/255, blue: 211/255)),
            CustomColor(name: "mediumpurple", color: Color(red: 147/255, green: 112/255, blue: 219/255)),
            CustomColor(name: "mediumseagreen", color: Color(red: 60/255, green: 179/255, blue: 113/255)),
            CustomColor(name: "mediumslateblue", color: Color(red: 123/255, green: 104/255, blue: 238/255)),
            CustomColor(name: "mediumturquoise", color: Color(red: 72/255, green: 209/255, blue: 204/255)),
            CustomColor(name: "mediumvioletred", color: Color(red: 199/255, green: 21/255, blue: 133/255)),
            CustomColor(name: "midnightblue", color: Color(red: 25/255, green: 25/255, blue: 112/255)),
            CustomColor(name: "olivedrab", color: Color(red: 107/255, green: 142/255, blue: 35/255)),
            CustomColor(name: "orange", color: Color(red: 255/255, green: 165/255, blue: 0/255)),
            CustomColor(name: "orangered", color: Color(red: 255/255, green: 69/255, blue: 0/255)),
            CustomColor(name: "orchid", color: Color(red: 218/255, green: 112/255, blue: 214/255)),
            CustomColor(name: "palevioletred", color: Color(red: 219/255, green: 112/255, blue: 147/255)),
            CustomColor(name: "plum", color: Color(red: 221/255, green: 160/255, blue: 221/255)),
            CustomColor(name: "powderblue", color: Color(red: 176/255, green: 224/255, blue: 230/255)),
            CustomColor(name: "purple", color: Color(red: 128/255, green: 0/255, blue: 128/255)),
            CustomColor(name: "royalblue", color: Color(red: 65/255, green: 105/255, blue: 225/255)),
            CustomColor(name: "salmon", color: Color(red: 250/255, green: 128/255, blue: 114/255)),
            CustomColor(name: "seagreen", color: Color(red: 46/255, green: 139/255, blue: 87/255)),
            CustomColor(name: "silver", color: Color(red: 192/255, green: 192/255, blue: 192/255)),
            CustomColor(name: "skyblue", color: Color(red: 135/255, green: 206/255, blue: 235/255)),
            CustomColor(name: "slateblue", color: Color(red: 106/255, green: 90/255, blue: 205/255)),
            CustomColor(name: "slategrey", color: Color(red: 112/255, green: 128/255, blue: 144/255)),
            CustomColor(name: "steelblue", color: Color(red: 70/255, green: 130/255, blue: 180/255)),
            CustomColor(name: "teal", color: Color(red: 0/255, green: 128/255, blue: 128/255)),
            CustomColor(name: "thistle", color: Color(red: 216/255, green: 191/255, blue: 216/255)),
            CustomColor(name: "tomato", color: Color(red: 255/255, green: 99/255, blue: 71/255)),
            CustomColor(name: "turquoise", color: Color(red: 64/255, green: 224/255, blue: 208/255)),
            CustomColor(name: "violet", color: Color(red: 238/255, green: 130/255, blue: 238/255)),
            CustomColor(name: "yellowgreen", color: Color(red: 154/255, green: 205/255, blue: 50/255))
        ]
    
    static var randomColor: Color {
        colors.randomElement()?.color ?? Color.white
    }
    
    static var shuffleColors: [Color] {
        colors.shuffled().map{ $0.color }
    }
}
