//
//  NumericalScale.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/16/21.
//

import SwiftUI

struct NumericalScale: View {
    @Binding var val: String
    
    var body: some View {
        VStack {
            TextField("Value", text: $val)
                .overlay(VStack{Divider().offset(x: 0, y: 20)})
                .padding().multilineTextAlignment(.center).keyboardType(.decimalPad)
        }
    }
}

struct NumericalScale_Previews: PreviewProvider {
    static var previews: some View {
        NumericalScale(val: .constant(""))
    }
}
