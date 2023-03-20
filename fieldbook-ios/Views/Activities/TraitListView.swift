//
//  TraitListView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/10/21.
//

import SwiftUI

struct TraitListView: View {
    @State private var showingImportAction = false
    @State private var variables: [ObservationVariable] = []
    @State private var loadingVariables = true
    
    private let observationVariableService = InjectionProvider.getObservationVariableService()
    
    enum SheetContent {
        case brapi, file, newTrait
    }
    
    @State private var sheetContent: SheetContent = .brapi
    @State private var showSheet = false
    
    var body: some View {
        VStack {
            if(!self.loadingVariables) {
                VStack {
                    if(variables.isEmpty) {
                        Text("No traits currently exist, press the ") + Text(Image(systemName: "plus.circle.fill")).foregroundColor(.black)  + Text(" to get started")
                    } else {
                        List {
                            ForEach(variables, id: \.self.internalId) { variable in
                                TraitListItem(variable: variable, deleteSuccess: {
                                    Task {
                                        await self.fetchStoredVariables()
                                    }
                                })
                            }
                        }
                        .listStyle(.plain)
                    }
                }
                .navigationTitle("Traits")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action:{showingImportAction = true}, label: {
                            SwiftUI.Image(systemName: "plus.circle.fill").foregroundColor(.black)
                        }).actionSheet(isPresented: $showingImportAction) {
                            ActionSheet(title: Text("Add Trait"), buttons: [
                                .cancel { },
                                .default(Text("via BrAPI"), action: {sheetContent = .brapi
                                    showSheet = true}),
                                .default(Text("From File"), action: {sheetContent = .file
                                    showSheet = true}),
                                .default(Text("Create Trait"), action: {sheetContent = .newTrait
                                    showSheet = true})
                            ])
                        }.sheet(isPresented: $showSheet, content: {
                            switch sheetContent {
                            case .brapi: BrAPITriatImportSheet(sheetName: "BrAPI")
                            case .file: SheetView(sheetName: "File")
                            case .newTrait: TraitEditSheet(sheetName: "New trait", variable: nil)
                            }
                            
                        })
                    }
                }
            }
        }.task {
            await fetchStoredVariables()
        }
    }
    
    private func fetchStoredVariables() async {
        self.loadingVariables = true
        do {
            self.variables = try observationVariableService.getAllObservationVariables()
        } catch {
            //todo show error
        }
        self.loadingVariables = false
    }
}

private struct TraitListItem: View {
    @State private var showingAction = false
    @State private var showingDeleteAlert = false
    @State private var showingSortSheet = false
    @State private var deleteError = false
    let variable: ObservationVariable
    let deleteSuccess: () -> Void
    private let observationVariableService = InjectionProvider.getObservationVariableService()
    
    var body: some View {
        HStack {
            Text(self.variable.name)
            Spacer()
            Button(action:{showingAction = true}, label: {
                SwiftUI.Image(systemName: "ellipsis").rotationEffect(.degrees(90))
            })
            .alert("Delete Trait?", isPresented: $showingDeleteAlert) {
                Button("No", role:.cancel) { }
                Button("Yes", role: .destructive) {
                    Task {
                        do {
                            try await self.deleteVariable()
                            self.deleteSuccess()
                        }  catch let FieldBookError.serviceError(message) {
                            print("error deleting study: \(String(describing: message))")
                            self.deleteError = true
                        }
                    }
                }
            }
            .alert(isPresented: $deleteError) {
                Alert(title: Text("Error"),
                          message: Text("Error removing trait"),
                          dismissButton: .default(Text("OK")))
            }
            .actionSheet(isPresented: $showingAction) {
                ActionSheet(title: Text("Edit Trait"), buttons: [
                    .cancel { },
                    .default(Text("Edit"), action: {self.showingSortSheet = true}),
                    .destructive(Text("Delete"), action: {self.showingDeleteAlert = true})
                ])
            }.sheet(isPresented: $showingSortSheet) {
                TraitEditSheet(sheetName: "Edit Trait", variable: variable)
            }
        }
    }
    
    private func deleteVariable() async throws {
        let removed = try observationVariableService.deleteObservationVariables([variable.internalId!])
        if(removed == 0) {
            throw FieldBookError.serviceError(message: "Variable wasn't removed")
        }
    }
}

struct TraitListView_Previews: PreviewProvider {
    static var previews: some View {
        TraitListView()
    }
}
