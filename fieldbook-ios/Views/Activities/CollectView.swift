//
//  CollectView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/11/21.
//

import SwiftUI

struct CollectView: View {
    @State private var selectedFields: [String] = ["Field Name", "Germplasm ID"]
    @State private var currentTrait = "Plant Height"
    @State private var currentVal: String = ""
    @State private var currentObservation: String = ""
    
    var body: some View {
        print("test")
        return VStack {
            HStack {
                Picker("Choose field to display", selection: $selectedFields[0]) {
                    Text("Plot")
                    Text("Plant")
                    Text("Row")
                    Text("Column")
                    Text("Field Name")
                    Text("Germplasm ID")
                }
                Text("Phenotyping Fall 2021")
                Spacer()
            }.padding(.leading).padding(.top)
            HStack {
                Picker("Choose field to display", selection: $selectedFields[0]) {
                    Text("Plot")
                    Text("Plant")
                    Text("Row")
                    Text("Column")
                    Text("Field Name")
                    Text("Germplasm ID")
                }
                Text("ABC123")
                Spacer()
            }.padding(.leading)
            HStack {
                Spacer()
                Image("main_trait_left_arrow_unpressed").resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                Spacer()
                Picker("Choose Trait", selection: $currentTrait) {
                    Text("Plant Height")
                    Text("Leaf Width")
                    Text("Leaf Length")
                }
                Spacer()
                Image("main_trait_right_unpressed").resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                Spacer()
            }.padding()
            HStack {
                Spacer()
                Image("main_entry_left_unpressed").resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                Spacer()
                VStack {
                    Text("Row: 1")
                    Text("Column: 1")
                }
                Spacer()
                Image("main_entry_right_unpressed").resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                Spacer()
            }.padding(.bottom)
            VStack {
//                TextScale()
//                NumericalScale()
                NominalScale(options: ["yes", "no"], selected: $currentVal)
            }.padding(.top)
        }.frame(maxHeight: .infinity, alignment: .topLeading)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
            }) {
                Image(systemName: "ellipsis.circle.fill")
            })
            .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button(action: {}) {
                                Image(systemName: "barcode.viewfinder")
                            }.foregroundColor(.black)
                            Spacer()
                            Button(action: {}) {
                                Image(systemName: "questionmark.square.fill")
                            }.foregroundColor(.black)
                            Spacer()
                            Button(action: {}) {
                                Image(systemName: "trash.fill")
                            }.foregroundColor(.black)
                        }
                    }
    }
}

struct CollectView_Previews: PreviewProvider {
    static var previews: some View {
        CollectView()
    }
}
