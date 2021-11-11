//
//  BrAPIImportSheet.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/10/21.
//

import SwiftUI

struct BrapiStudyImportSheet: View {
    @Environment(\.dismiss) var dismiss
    let sheetName: String
    @State private var selectedObservationLevel = "Plot"
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Base URL").bold().padding()
                    Text("https://rel-test.breedinginsight.net/brapi/v2")
                    Spacer()
                }
                HStack {
                    Text("Observation Level").bold().padding()
                    Picker("Choose an observation level", selection: $selectedObservationLevel) {
                        Text("Plot")
                        Text("Plant")
                        Text("Row")
                        Text("Column")
                    }
                    Spacer()
                }
                List {
                    NavigationLink(destination: BrAPIPreviewField(studyTitle: "Phenotyping Fall 2021")) {
                        Text("Phenotyping Fall 2021")
                    }
                    NavigationLink(destination: BrAPIPreviewField(studyTitle: "Phenotyping Spring 2021")) {
                        Text("Phenotyping Spring 2021")
                    }
                    NavigationLink(destination: BrAPIPreviewField(studyTitle: "Phenotyping Summer 2021")) {
                        Text("Phenotyping Summer 2021")
                    }
                    NavigationLink(destination: BrAPIPreviewField(studyTitle: "Phenotyping Winter 2021")) {
                        Text("Phenotyping Winter 2021")
                    }
                }.listStyle(.plain)
                Spacer()
            }
            .navigationBarTitle(Text("BrAPI Field Import"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                print("Dismissing sheet view...")
                self.dismiss()
            }) {
                Text("Cancel").bold()
            })
        }
    }
}

struct BrAPIPreviewField: View {
    @State private var selectedObservationLevel: String = "Plot"
    let studyTitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Observation Level").bold().padding()
                Picker("Choose an observation level", selection: $selectedObservationLevel) {
                    Text("Plot")
                    Text("Plant")
                    Text("Row")
                    Text("Column")
                }.pickerStyle(.menu)
                Spacer()
                Button("Reload", action: {}).padding()
            }
            HStack {
                Text("Name:").bold().padding()
                Text(studyTitle)
                Spacer()
            }
            Text("Description:").bold().padding(.leading)
            Text("Phenotyping efforts for the fall of 2021 in the Oregon fields").padding(.leading)
            HStack {
                Text("Location:").bold().padding()
                Text("Oregon")
                Spacer()
            }
            HStack {
                Text(selectedObservationLevel + ":").bold().padding()
                Text("800")
                Spacer()
            }
            HStack {
                Text("Traits:").bold().padding()
                Text("18")
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                Button("Save Field", action: {}).buttonStyle(.borderedProminent)
                Spacer()
            }
        }
    }
}

struct BrAPIImportSheet_Previews: PreviewProvider {
    static var previews: some View {
        BrapiStudyImportSheet(sheetName: "Test")
        BrAPIPreviewField(studyTitle: "Phenotyping Fall 2021")
    }
}
