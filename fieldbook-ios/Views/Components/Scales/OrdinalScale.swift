//
//  OrdinalScale.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/16/21.
//

import SwiftUI
import WrappingHStack

struct OrdinalScale: View {
    var options: [BrAPIScaleCategories]
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
        OrdinalScale(options: [BrAPIScaleCategories(value:"1sdfasdfasdf"), BrAPIScaleCategories(value:"2asdfasdf"), BrAPIScaleCategories(value:"3asdfasdf"), BrAPIScaleCategories(value:"4asdfasdf")], selected: .constant("1sdfasdfasdf"))
    }
}
