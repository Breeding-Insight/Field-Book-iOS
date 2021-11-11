//
//  FieldListView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/6/21.
//

import SwiftUI

struct FieldListView: View {
    @State private var showingImportAction = false
    
    enum SheetContent {
            case brapi, file, newField
        }
        
    @State private var sheetContent: SheetContent = .brapi
    @State private var showSheet = false
    
    var body: some View {
        List {
            Field(name:"Field A")
            Field(name:"Field B")
            Field(name:"Field C")
            //todo get fields from internal database
        }
        .navigationTitle("Fields")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action:{showingImportAction = true}, label: {
                    Image(systemName: "plus.circle.fill").foregroundColor(.black)
                }).actionSheet(isPresented: $showingImportAction) {
                    ActionSheet(title: Text("Add Field"), buttons: [
                        .cancel { },
                        .default(Text("via BrAPI"), action: {sheetContent = .brapi
                            showSheet = true}),
                        .default(Text("From File"), action: {sheetContent = .file
                            showSheet = true}),
                        .default(Text("Create Field"), action: {sheetContent = .newField
                            showSheet = true})
                    ])
                }.sheet(isPresented: $showSheet, content: {
                    switch sheetContent {
                        case .brapi: BrapiStudyImportSheet(sheetName: "BrAPI")
                        case .file: SheetView(sheetName: "File")
                        case .newField: SheetView(sheetName: "New field")
                    }
                    
                })
            }
        }
    }
}

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    let sheetName: String
    
    var body: some View {
        VStack {
            Button("Press to dismiss") {
                dismiss()
            }
            .font(.title)
            .padding()
            .background(Color.black)
            Text(self.sheetName)
        }
    }
}

struct Field: View {
    @State private var showingAction = false
    @State private var showingDeleteAlert = false
    @State private var showingSortSheet = false
    let name: String
    
    var body: some View {
        HStack {
            Text(self.name)
            Spacer()
            Button(action:{showingAction = true}, label: {
                Image(systemName: "ellipsis").rotationEffect(.degrees(90))
            })
                .alert("Delete Field?", isPresented: $showingDeleteAlert) {
                    Button("No", role:.cancel) { }
                    Button("Yes", role: .destructive) { }
                }
                .actionSheet(isPresented: $showingAction) {
                    ActionSheet(title: Text("Edit Field"), buttons: [
                        .cancel { },
                        .default(Text("Update Sort"), action: {self.showingSortSheet = true}),
                        .destructive(Text("Delete"), action: {self.showingDeleteAlert = true})
                    ])
                }.sheet(isPresented: $showingSortSheet) {
                    SheetView(sheetName: "Sorting")
                }
        }
    }
}

struct FieldListView_Previews: PreviewProvider {
    static var previews: some View {
        FieldListView()
    }
}
