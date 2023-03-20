//
//  CreateFieldSheet.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/10/21.
//

import SwiftUI
import RadioGroup

struct FieldEditSheet: View {
    @Environment(\.dismiss) var dismiss
    private let sheetName: String
    private var study: Study? = nil
    @State private var name: String = ""
    @State private var details: String = ""
    @State private var rows: String = ""
    @State private var columns: String = ""
    
    @State private var startPosition = 0
    private let startPositionSources = ["Top Left", "Top Right", "Bottom Left", "Bottom Right"]
    @State private var navOrder = 0
    
    private let studyDAO: StudyDAO = InjectionProvider.getStudyDAO()
    
    init(sheetName: String, study: Study?) {
        self.sheetName = sheetName
        if(study != nil) {
            self.study = study
            self._name = State(initialValue: study!.name)
            self._details = State(initialValue:study!.description ?? "")
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text("Name").bold().padding()
                        TextField("Name", text: $name).disableAutocorrection(true).submitLabel(.done)
                            .padding()
                    }
                    HStack {
                        Text("Description").bold().padding()
                        TextField("Description", text: $details).disableAutocorrection(true).submitLabel(.done)
                            .padding()
                    }
                    HStack {
                        Text("Rows").bold().padding()
                        TextField("Rows", text: $rows).keyboardType(.decimalPad).disableAutocorrection(true).submitLabel(.done)
                            .padding()
                    }
                    HStack {
                        Text("Columns").bold().padding()
                        TextField("Columns", text: $columns).keyboardType(.decimalPad).disableAutocorrection(true).submitLabel(.done)
                            .padding()
                    }
                    HStack {
                        Text("Start Position").bold().padding()
                        RadioGroupPicker(selectedIndex: $startPosition, titles: startPositionSources)
                            .selectedColor(.black)
                            .itemSpacing(15)
                            .titleColor(.black)
                            .titleAlignment(.right)
                            .fixedSize()
                            .padding(8)
                            .accentColor(.black)
                        Spacer()
                    }
                    HStack {
                        Text("Field Pattern").bold().padding()
                        RadioGroupPicker(selectedIndex: $navOrder, titles: ["Zigzag", "Serpentine"])
                            .selectedColor(.black)
                            .itemSpacing(15)
                            .titleColor(.black)
                            .titleAlignment(.right)
                            .fixedSize()
                            .padding(8)
                            .accentColor(.black)
                        Spacer()
                    }
                    Spacer()
                }
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

struct CreateFieldSheet_Previews: PreviewProvider {
    static var previews: some View {
        FieldEditSheet(sheetName: "New Field", study: nil)
    }
}
