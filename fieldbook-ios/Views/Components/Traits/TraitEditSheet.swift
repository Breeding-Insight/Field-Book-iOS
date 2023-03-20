//
//  TraitEditSheet.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 10/3/22.
//

import Foundation
import SwiftUI

struct TraitEditSheet: View {
    @Environment(\.dismiss) var dismiss
    private let sheetName: String
    private var variable: ObservationVariable? = nil
    @State private var name: String = ""
    @State private var details: String = ""
    @State private var categories: String = ""
    @State private var format: TraitFormat = TraitFormat.text
    private let variableDAO: ObservationVariableDAO = InjectionProvider.getObservationVariableDAO()
    
    init(sheetName: String, variable: ObservationVariable?) {
        self.sheetName = sheetName
        if(variable != nil) {
            self.variable = variable
            self._name = State(initialValue: variable!.name)
            self._details = State(initialValue:variable!.details ?? "")
            self._format = State(initialValue:variable!.fieldBookFormat ?? TraitFormat.text)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Trait").bold().padding()
                    TextField("Trait", text: $name)
                        .padding()
                }
                HStack {
                    Text("Details").bold().padding()
                    TextField("Details", text: $details)
                        .padding()
                }
                HStack {
                    Text("Format").bold().padding()
                    Picker("Choose a trait format", selection: $format) {
                        
                        ForEach(TraitFormat.allCases, id: \.self) { value in
                                            Text(value.rawValue)
                                                .tag(value)
                                        }
                    }
                    Spacer()
                }
                if(format == TraitFormat.categorical) {
                    HStack {
                        Text("Categories").bold().padding()
                        TextField("Categories", text: $categories)
                                                .padding()
                    }
                }
                Spacer()
            }
            .navigationBarTitle(Text(sheetName), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                print("Dismissing sheet view...")
                self.dismiss()
            }) {
                Text("Cancel").bold()
            })
            .navigationBarItems(trailing: Button(action: {
                self.dismiss()
            }) {
                Text("Save").bold()
            })
        }
    }
}

struct TraitEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        TraitEditSheet(sheetName: "New Trait", variable: nil)
    }
}
