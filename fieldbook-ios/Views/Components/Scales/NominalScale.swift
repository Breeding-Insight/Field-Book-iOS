//
//  NominalScale.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/16/21.
//

import SwiftUI
import WrappingHStack

struct NominalScale: View {
    var options: [BrAPIScaleCategories]
    @Binding var selected: String
    @State private var displayLabels = Int(UserDefaults.standard.string(forKey:PreferenceConstants.BRAPI_LABEL_DISPLAY) ?? "0") == 1
    
    var body: some View {
        WrappingHStack(options, id:\.self, alignment: .center) {option in
            if (option.value == selected) {
                Button((self.displayLabels ? option.label! : option.value!)) {
                    buttonPressed(val: option.value!)
                }
                    .buttonStyle(FilledButtonStyle())
                    .padding(.bottom).fixedSize(horizontal: true, vertical: false)
            } else {
                Button((self.displayLabels ? option.label! : option.value!)) {
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

struct NominalScale_Previews: PreviewProvider {
    static var previews: some View {
        NominalScale(options: [BrAPIScaleCategories(value:"Low"), BrAPIScaleCategories(value:"kinda low"), BrAPIScaleCategories(value:"kinda high"), BrAPIScaleCategories(value:"high")], selected: .constant("kinda low"))
    }
}
