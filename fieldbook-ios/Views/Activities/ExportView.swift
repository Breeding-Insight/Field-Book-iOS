//
//  ExportView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 3/23/23.
//

import SwiftUI
import os

struct ExportView: View {
    private let logger = Logger(subsystem: "org.phenoapps.fieldbook", category: "ExportView")
    
    @EnvironmentObject private var appState: AppState
    @State private var loadingData = true
    @State private var exporting = false
    @State private var error = false
    @State private var exportError = false
    @State private var exportComplete = false
    @State private var obsInError: Observation?
    @State private var newObs = 0
    @State private var syncedObs = 0
    @State private var editedObs = 0
    @State private var diffSourceObs = 0
    @State private var obsToSync = 0
    @State private var syncSuccess = 0
    @State private var study: Study?
    @State private var traitsDict: [Int64:ObservationVariable] = [:]
    
    private let studyService = InjectionProvider.getStudyService()
    private let observationVariableService = InjectionProvider.getObservationVariableService()
    private let brapiObservationService = InjectionProvider.getBrAPIObservationService()
    private let observationDAO = InjectionProvider.getObservationDAO()
    private let dateFormatter = DateFormatter()
    
    init() {
        self.dateFormatter.dateFormat = "YYYY-MM-DD HH:MM:SS.SSS"
    }
    
    var body: some View {
        return VStack(alignment: .leading) {
            if(!loadingData) {
                HStack {
                    Text("Field: ")
                    Text("\(study!.name)")
                }
                Group {
                    Text("Observations")
                        .bold()
                        .padding(.top)
                    HStack {
                        VStack(alignment:.trailing) {
                            Text("\(newObs)")
                            Text("\(syncedObs)")
                            Text("\(editedObs)")
                        }.padding(.trailing, 10)
                        VStack(alignment:.leading) {
                            Text("New Observations")
                            Text("Synced Observations")
                            Text("Edited Observations")
                        }
                    }
                    Text("Skipped Observations")
                        .bold()
                        .padding(.top)
                    HStack {
                        VStack(alignment:.trailing) {
                            Text("0")
                            Text("\(diffSourceObs)")
                        }.padding(.trailing, 10)
                        VStack(alignment:.leading) {
                            Text("User Created Trait Observations")
                            Text("Different Data Source")
                        }
                    }
                }
                Group {
                    Text("Images")
                        .bold()
                        .padding(.top)
                    HStack {
                        VStack(alignment:.trailing) {
                            Text("0")
                            Text("0")
                            Text("0")
                            Text("0")
                        }.padding(.trailing, 10)
                        VStack(alignment:.leading) {
                            Text("New Images")
                            Text("Synced Images")
                            Text("Edited Images")
                            Text("Incomplete Synced Images")
                        }
                    }
                    Text("Skipped Images")
                        .bold()
                        .padding(.top)
                    HStack {
                        VStack(alignment:.trailing) {
                            Text("0")
                            Text("0")
                        }.padding(.trailing, 10)
                        VStack(alignment:.leading) {
                            Text("User Created Trait Images")
                            Text("Different Data Source")
                        }
                    }
                }
                Spacer()
                if self.exporting {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }.padding(.bottom)
                    ProgressView(value: Double(self.syncSuccess), total: Double(self.obsToSync))
                        .progressViewStyle(LinearProgressViewStyle())
                        .labelsHidden()
                        .tint(Colors.primaryFB)
                        .foregroundColor(.gray)
                } else if self.exportComplete {
                    HStack {
                        Spacer()
                        Text("Export was successful!")
                        Spacer()
                    }
                }
                HStack {
                    Spacer()
                    Button("Export") {
                        Task {
                            do {
                                try await self.exportData()
                            } catch {
                                logger.error("error exporting observation: \(error.localizedDescription)")
                            }
                        }
                    }
                    .disabled(self.exporting || self.syncSuccess == self.obsToSync)
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom)
                    .padding(.top)
                    Spacer()
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Export")
        .task {
            self.loadData()
        }
        .alert(isPresented: $error) {
            var errorMsg = "An unknown error occurred"
            if self.exportError {
                errorMsg = "Unable to export observations"
                if self.obsInError != nil {
                    errorMsg = "Error exporting observation for \(obsInError!.observationUnitId!)/\(traitsDict[obsInError!.observationVariableId!]!.name)"
                }
            }
            
            return Alert(title: Text("Error"), message: Text(errorMsg), dismissButton: .default(Text("Ok")))
        }
    }
    
    func loadData() {
        do {
            let traits = try observationVariableService.getAllObservationVariables()
            var traitsDict: [Int64:ObservationVariable] = [:]
            for trait in traits {
                traitsDict[trait.internalId!] = trait
            }
            self.traitsDict = traitsDict
            
            let study = try studyService.getStudy(appState.currentStudyId!)
            self.study = study
            
            let lastSynced = UserDefaults.standard.string(forKey:PreferenceConstants.BRAPI_LAST_SYNCED) != nil ? dateFormatter.date(from: UserDefaults.standard.string(forKey:PreferenceConstants.BRAPI_LAST_SYNCED)!) : nil

            var newObs = 0
            var syncedObs = 0
            var editedObs = 0
            
            if(study?.observationUnits != nil) {
                self.study = study
                if(study?.observationUnits != nil) {
                    for ou in study!.observationUnits {
                        if ou.observations != nil {
                            for obs in ou.observations! {
                                let trait = traitsDict[obs.observationVariableId!]!
                                if(trait.externalDbId != nil && trait.traitDataSource == SettingsUtilities.getBrAPIBaseUrl()) {
                                    if obs.lastSyncedTime == nil {
                                        newObs += 1
                                    } else if lastSynced != nil && obs.lastSyncedTime != nil && obs.lastSyncedTime! != lastSynced! {
                                        editedObs += 1
                                    } else {
                                        syncedObs += 1
                                    }
                                } else if trait.traitDataSource != SettingsUtilities.getBrAPIBaseUrl() {
                                    diffSourceObs += 1
                                }
                            }
                        }
                    }
                }
            }
            self.newObs = newObs
            self.syncedObs = syncedObs
            self.editedObs = editedObs
            self.obsToSync = newObs + editedObs
        } catch {
            logger.error("unknown error: \(error.localizedDescription)")
        }
        self.loadingData = false
    }
    
    func exportData() async throws {
        self.exporting = true
        
        let lastSynced = UserDefaults.standard.string(forKey:PreferenceConstants.BRAPI_LAST_SYNCED) != nil ? dateFormatter.date(from: UserDefaults.standard.string(forKey:PreferenceConstants.BRAPI_LAST_SYNCED)!) : nil
        
        var syncObsIds: [Int64] = []
        for ou in study!.observationUnits {
            if ou.observations != nil {
                for obs in ou.observations! {
                    let trait = self.traitsDict[obs.observationVariableId!]!
                    if(trait.externalDbId != nil) {
                        let isNew = obs.lastSyncedTime == nil && obs.observationDbId == nil
                        let isEdited = lastSynced != nil && obs.lastSyncedTime != nil && obs.lastSyncedTime != lastSynced!
                        
                        if isNew || isEdited {
                            do {
                                _ = try await brapiObservationService.exportObservation(obs)
                                
                                if isNew {
                                    self.newObs -= 1
                                } else {
                                    self.editedObs -= 1
                                }
                                self.syncedObs += 1
                                self.syncSuccess += 1
                                syncObsIds.append(obs.internalId!)
                            } catch {
                                self.obsInError = obs
                                self.error = true
                                self.exportError = true
                                self.exporting = false
                                throw error
                            }
                        }
                    }
                }
            }
        }
        
        do {
            let lastSynced = Date.now
            try observationDAO.setLastSynced(syncObsIds, lastSynced: lastSynced)
            UserDefaults.standard.set(dateFormatter.string(from: lastSynced), forKey: PreferenceConstants.BRAPI_LAST_SYNCED)
        } catch {
            self.error = true
            self.exporting = false
        }
        
        self.exportComplete = true
        self.exporting = false
    }
}
