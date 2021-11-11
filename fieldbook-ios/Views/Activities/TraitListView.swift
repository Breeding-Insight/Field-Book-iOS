//
//  TraitListView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/10/21.
//

import SwiftUI

struct TraitListView: View {
    @State private var showingImportAction = false
    
    enum SheetContent {
            case brapi, file, newTrait
        }
        
    @State private var sheetContent: SheetContent = .brapi
    @State private var showSheet = false
    
    var body: some View {
        List {
            Trait(name:"Trait A")
            Trait(name:"Trait B")
            Trait(name:"Trait C")
            //todo get fields from internal database
        }
        .navigationTitle("Traits")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action:{showingImportAction = true}, label: {
                    Image(systemName: "plus.circle.fill").foregroundColor(.black)
                }).actionSheet(isPresented: $showingImportAction) {
                    ActionSheet(title: Text("Add Trait"), buttons: [
                        .cancel { },
                        .default(Text("via BrAPI"), action: {sheetContent = .brapi
                            showSheet = true}),
                        .default(Text("From File"), action: {sheetContent = .file
                            showSheet = true}),
                        .default(Text("Create Field"), action: {sheetContent = .newTrait
                            showSheet = true})
                    ])
                }.sheet(isPresented: $showSheet, content: {
                    switch sheetContent {
                        case .brapi: BrAPITriatImportSheet(sheetName: "BrAPI")
                        case .file: SheetView(sheetName: "File")
                        case .newTrait: SheetView(sheetName: "New trait")
                    }
                    
                })
            }
        }
    }
}

private struct Trait: View {
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
                .alert("Delete Trait?", isPresented: $showingDeleteAlert) {
                    Button("No", role:.cancel) { }
                    Button("Yes", role: .destructive) { }
                }
                .actionSheet(isPresented: $showingAction) {
                    ActionSheet(title: Text("Edit Trait"), buttons: [
                        .cancel { },
                        .default(Text("Edit"), action: {self.showingSortSheet = true}),
                        .destructive(Text("Delete"), action: {self.showingDeleteAlert = true})
                    ])
                }.sheet(isPresented: $showingSortSheet) {
                    SheetView(sheetName: "Editing Trait")
                }
        }
    }
}

struct TraitListView_Previews: PreviewProvider {
    static var previews: some View {
        FieldListView()
    }
}
