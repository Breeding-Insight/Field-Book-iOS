//
//  TextScale.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/16/21.
//

import SwiftUI

struct TextScale: View {
    @State private var val = ""
    var body: some View {
        VStack {
            TextField("Value", text: $val)
                .overlay(VStack{Divider().offset(x: 0, y: 20)})
                .padding().multilineTextAlignment(.center)
        }
    }
}

struct TextScale_Previews: PreviewProvider {
    static var previews: some View {
        TextScale()
    }
}
