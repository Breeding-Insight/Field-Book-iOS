//
//  OrdinalScale.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/16/21.
//

import SwiftUI
import WrappingHStack

struct OrdinalScale: View {
    var options: [ScaleCategories]
    @Binding var selected: String
    
    var body: some View {
        WrappingHStack(options, id:\.self, alignment: .center) {option in
            if (option.value == selected) {
                Button(option.value!) {
                    buttonPressed(val: option.value!)
                }
                    .buttonStyle(FilledButtonStyle())
                    .padding(.bottom).fixedSize(horizontal: true, vertical: false)
            } else {
                Button(option.value!) {
                    buttonPressed(val: option.value!)
                }
                    .buttonStyle(OutlinedButtonStyle())
                    .padding(.bottom)
                    .fixedSize(horizontal: true, vertical: false)
            }
        }
    }
    
    func buttonPressed(val:String) -> Void {
        selected = val
    }
}

struct OrdinalScale_Previews: PreviewProvider {
    static var previews: some View {
        OrdinalScale(options: [ScaleCategories(value:"1sdfasdfasdf"), ScaleCategories(value:"2asdfasdf"), ScaleCategories(value:"3asdfasdf"), ScaleCategories(value:"4asdfasdf")], selected: .constant("1sdfasdfasdf"))
    }
}
