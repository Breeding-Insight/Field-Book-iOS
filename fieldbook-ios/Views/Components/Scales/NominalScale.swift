//
//  NominalScale.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/16/21.
//

import SwiftUI
import WrappingHStack

struct NominalScale: View {
    var options: [String]
    @Binding var selected: String
    
    var body: some View {
        WrappingHStack(options, id:\.self, alignment: .center) {option in
            if (option == selected) {
                Button(option) {
                    buttonPressed(val: option)
                }
                    .buttonStyle(FillStyle())
                    .padding(.bottom).fixedSize(horizontal: true, vertical: false)
            } else {
                Button(option) {
                    buttonPressed(val: option)
                }
                    .buttonStyle(OutlineStyle())
                    .padding(.bottom)
                    .fixedSize(horizontal: true, vertical: false)
            }
        }
    }
    
    func buttonPressed(val:String) -> Void {
        selected = val
    }
}

struct OutlineStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(minWidth: 44, minHeight: 44)
            .padding(.horizontal)
            .foregroundColor(configuration.isPressed ? .gray : .black)
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
    }
}

struct FillStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 44, minHeight: 44)
            .padding(.horizontal)
            .foregroundColor(configuration.isPressed ? .gray : .black)
            .background(Color.primaryFB)
            .cornerRadius(10)
    }
}

struct NominalScale_Previews: PreviewProvider {
    static var previews: some View {
        NominalScale(options: ["1sdfasdfasdf", "2asdfasdf", "3asdfasdf", "4asdfasdf"], selected: .constant("1sdfasdfasdf"))
    }
}
