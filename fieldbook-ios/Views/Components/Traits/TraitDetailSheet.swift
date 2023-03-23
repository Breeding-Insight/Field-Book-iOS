//
//  TraitDetailSheet.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 3/22/23.
//

import Foundation
import SwiftUI

struct TraitDetailSheet: View {
    @Environment(\.dismiss) var dismiss
    var variable: ObservationVariable
    
    var body: some View {
        VStack {
            HStack {
                Text("Trait").bold().padding()
                Text(self.variable.name)
                Spacer()
            }
            HStack {
                Text("Details").bold().padding()
                Text(self.variable.details ?? "")
                Spacer()
            }
            HStack {
                Text("Format").bold().padding()
                Text(self.variable.fieldBookFormat?.get() ?? "")
                Spacer()
            }
            if(self.variable.fieldBookFormat == TraitFormat.categorical) {
                HStack {
                    Text("Categories").bold().padding()
                    ForEach(self.getCategories(), id: \.self) { category in
                        Text(category)
                    }
                    Spacer()
                }
            }
            Spacer()
        }
    }
    
    private func getCategories() -> [String] {
        let attrVal: ObservationVariableAttributeValue = variable.attributes![ObservationVariableAttribute(attributeName: "category")]!
        
        let decoder = JSONDecoder()
        let data = attrVal.value.data(using: .utf8)!

        let catVals = try? decoder.decode([[String:String]].self, from: data)
        
        var categories: [String] = []
        
        for cat in catVals! {
            let value = cat["value"]!
            
            var label = value
            if cat["label"] != nil {
                label = cat["label"]!
            }
            
            if(value == label) {
                categories.append(value)
            } else {
                categories.append("\(label) = \(value)")
            }
        }
        
        return categories
    }
}
