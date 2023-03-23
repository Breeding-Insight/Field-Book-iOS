//
//  BrAPITrialImportSheet.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/10/21.
//

import SwiftUI
import os

struct BrAPITriatImportSheet: View {
    private let logger = Logger(subsystem: "org.phenoapps.fieldbook", category: "BrAPITriatImportSheet")
    
    @Environment(\.dismiss) var dismiss
    let sheetName: String
    private let brapiVariableService = InjectionProvider.getBrAPIVariableService()
    private let variableService = InjectionProvider.getObservationVariableService()
    
    @State private var variablesLoading = true
    @State private var variables: [ObservationVariable]?
    @State private var selectedVars: [String: Bool] = [:]
    @State private var hasSelectedAll = false
    @State private var savingTraits = false
    @State private var saveTraitsError = false
    @State private var saveTraitsErrorMessage: String?
    @State private var fetchTraitsError = false
    @State private var error = false;
    
    private func isSelected(_ variable: ObservationVariable) -> Image {
        var icon = "square"
        if(selectedVars[variable.externalDbId!]!) {
            icon = "checkmark.square.fill"
        }
        
        return SwiftUI.Image(systemName: icon)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Base URL").bold().padding()
                    Text(SettingsUtilities.getBrAPIBaseUrl()!)
                    Spacer()
                }
                if !self.variablesLoading {
                    HStack {
                        SwiftUI.Image(systemName: self.hasSelectedAll ? "checkmark.square.fill" : "square")
                            .padding(.leading, 20)
                        Text("Select All")
                        Spacer()
                    }.onTapGesture {
                        self.hasSelectedAll = !self.hasSelectedAll
                        selectedVars.keys.forEach{ key in
                            selectedVars[key]! = self.hasSelectedAll
                        }
                    }
                }
                if(!variablesLoading) {
                    List {
                        ForEach(variables!, id: \.self.externalDbId) { variable in
                            HStack {
                                self.isSelected(variable).onTapGesture {
                                    selectedVars[variable.externalDbId!]! = !(selectedVars[variable.externalDbId!]!)
                                }
                                NavigationLink(destination: TraitDetailSheet(dismiss: _dismiss, variable: variable)) {
                                    Text(variable.name)
                                }
                            }
                        }
                    }.listStyle(.plain)
                } else {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
                Spacer()
                if !self.variablesLoading {
                    if !self.saveTraitsError {
                        Spacer()
                        Button("Save Traits", action: {
                            self.savingTraits = true
                            Task {
                                do {
                                    try await self.saveTraits()
                                    self.dismiss()
                                } catch let FieldBookError.serviceError(message) {
                                    logger.error("error saving traits: \(String(describing: message))")
                                    self.saveTraitsError = true
                                    self.saveTraitsErrorMessage = nil
                                } catch let FieldBookError.nameConflictError(message) {
                                    self.saveTraitsError = true
                                    self.saveTraitsErrorMessage = message
                                }
                            }
                        })
                            .buttonStyle(.borderedProminent).padding(.bottom).disabled(self.savingTraits)
                        Spacer()
                    }
                }
            }
            .navigationBarTitle(Text("BrAPI Trait Import"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                logger.debug("Dismissing sheet view...")
                self.dismiss()
            }) {
                Text("Cancel").bold()
            })
            .navigationBarItems(trailing: Button(action: {
                Task {
                    await self.fetchVariables()
                }
            }) {
                Text("Reload")
            })
            .task {
                if self.variablesLoading {
                    await self.fetchVariables()
                }
            }
            .alert(isPresented: $error) {
                var errorMsg = "An unknown error occurred"
                if self.saveTraitsError {
                    if self.saveTraitsErrorMessage != nil {
                        errorMsg = self.saveTraitsErrorMessage!
                    } else {
                        errorMsg = "Unable to save traits"
                    }
                }
                
                return Alert(title: Text("Error"), message: Text(errorMsg), dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    private func fetchVariables() async {
        self.variablesLoading = true
        self.hasSelectedAll = false
        self.fetchTraitsError = false
        do {
            let fetchedVariables = try await brapiVariableService.fetchAvailableObservationVariables()
            self.variables = fetchedVariables
            
            variables?.forEach {variable in
                selectedVars[variable.externalDbId!] = false
            }
        } catch {
            logger.error("Error fetching variables: \(error.localizedDescription)")
            self.error = true
            self.fetchTraitsError = true
        }
        self.variablesLoading = false
    }
    
    private func saveTraits() async throws {
        self.savingTraits = true
        self.saveTraitsError = false
        
        var traitsToSave: [ObservationVariable] = []
        for variable in self.variables! {
            if selectedVars[variable.externalDbId!]! {
                traitsToSave.append(variable)
            }
        }
        
        do {
            _ = try variableService.saveObservationVariables(traitsToSave)
        } catch {
            self.error = true
            throw error
        }
        self.savingTraits = false
    }
}

//struct BrAPITriatImportSheet_Previews: PreviewProvider {
//    static var previews: some View {
////        BrAPITriatImportSheet(sheetName: "Test")
////        BrAPIPreviewTrait()
//    }
//}

