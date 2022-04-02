//
//  Styles.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/19/21.
//

import SwiftUI

struct OutlinedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(minWidth: 44, minHeight: 44)
            .padding(.horizontal)
            .foregroundColor(configuration.isPressed ? .gray : .black)
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
    }
}

struct FilledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 44, minHeight: 44)
            .padding(.horizontal)
            .foregroundColor(configuration.isPressed ? .gray : .black)
            .background(Color.primaryFB)
            .cornerRadius(10)
    }
}
