//
//  CodeScale.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/16/21.
//

import SwiftUI

struct CodeScale: View {
    @State private var val = ""
    
    var body: some View {
        VStack {
            TextField("Value", text: $val)
                .overlay(VStack{Divider().offset(x: 0, y: 15)})
                .padding()
        }
    }
}

struct CodeScale_Previews: PreviewProvider {
    static var previews: some View {
        CodeScale()
    }
}
