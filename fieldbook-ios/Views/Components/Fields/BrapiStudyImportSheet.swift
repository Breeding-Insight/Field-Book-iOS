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
    private let brapiStudyService = InjectionProvider.getBrAPIStudyService()
    
    @State private var selectedObservationLevel: String = "plot"
    @State private var studies: [Study]?
    @State private var levels: [String]?
    @State private var studiesLoading = true
    @State private var levelsLoading = true
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Base URL").bold().padding()
                    Text(SettingsUtilities.getBrAPIUrl())
                    Spacer()
                }
                if(!levelsLoading) {
                    HStack {
                        Text("Observation Level").bold().padding()
                        Picker("Choose an observation level", selection: $selectedObservationLevel) {
                            ForEach(levels!, id: \.self) { level in
                                Text(level)
                            }
                        }
                        Spacer()
                    }
                    List {
                        if(!studiesLoading) {
                            ForEach(studies!, id: \.self.studyDbId) { study in
                                NavigationLink(destination: BrAPIPreviewField(dismiss: _dismiss, study: study, levels: levels!, selectedObservationLevel: selectedObservationLevel)) {
                                    Text(study.name)
                                }
                            }
                        } else {
                            ProgressView()
                        }
                    }.listStyle(.plain)
                    Spacer()
                } else {
                    ProgressView()
                    Spacer()
                }
            }
            .navigationBarTitle(Text("BrAPI Field Import"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                print("Dismissing sheet view...")
                self.dismiss()
            }) {
                Text("Cancel").bold()
            }).task {
                await self.fetchLevels()
            }.task {
                await self.fetchStudies()
            }
        }
    }
    
    private func fetchStudies() async {
        do {
            let fetchedStudies = try await brapiStudyService.fetchStudiesFromRemote()
            self.studies = fetchedStudies
        } catch {
            //todo show an error
        }
        self.studiesLoading = false
    }
    
    private func fetchLevels() async {
        do {
            self.levels = try await brapiStudyService.fetchAvailableObservationLevels()
        } catch {
            print("Error fetching levels: \(error.localizedDescription)")
            //todo show an error
        }
        self.levelsLoading = false
    }
}

struct BrAPIPreviewField: View {
    @Environment(\.dismiss) var dismiss
    let study: Study
    let levels: [String]
    @State var selectedObservationLevel: String
    @State private var studyDetails: Study?
    @State private var studyDetailsLoading = true
    @State private var savingStudy = false
    @State private var saveStudyError = false
    @State private var saveStudyErrorMessage: String?
    @State private var fetchStudyError = false
    @State private var fetchStudyErrorMessage: String?
    
    private let brapiStudyService = InjectionProvider.getBrAPIStudyService()
    private let studyService = InjectionProvider.getStudyService()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Observation Level").bold().padding()
                Picker("Choose an observation level", selection: $selectedObservationLevel) {
                    ForEach(self.levels, id: \.self) { level in
                        Text(level)
                    }
                }.pickerStyle(.menu).disabled(self.studyDetailsLoading || self.savingStudy)
                Spacer()
                Button("Reload", action: {
                    self.studyDetailsLoading = true
                    Task {
                        await self.fetchStudyDetails()
                    }
                }).padding().disabled(self.studyDetailsLoading || self.savingStudy)
            }
            HStack {
                Text("Name:").bold().padding()
                Text(self.study.name)
                Spacer()
            }
            Text("Description:").bold().padding(.leading)
            Text(self.study.description ?? "").padding(.leading)
            HStack {
                Text("Location:").bold().padding()
                Text(study.locationName ?? "")
                Spacer()
            }
            if(!self.studyDetailsLoading) {
                if(self.fetchStudyError) {
                    Text("Error fetching details for study \"\(self.study.name)\"")
                } else {
                    HStack {
                        Text(self.selectedObservationLevel + ":").bold().padding()
                        Text(String(self.studyDetails?.observationUnits.count ?? 0))
                        Spacer()
                    }
                    HStack {
                        Text("Traits:").bold().padding()
                        Text(String(self.studyDetails?.observationVariables.count ?? 0))
                        Spacer()
                    }
                    Spacer()
                    if(!saveStudyError) {
                        HStack {
                            Spacer()
                            Button("Save Field", action: {
                                self.savingStudy = true
                                Task {
                                    do {
                                        try await self.saveField()
                                        self.dismiss()
                                    } catch let FieldBookError.serviceError(message) {
                                        print("error saving study: \(String(describing: message))")
                                        self.saveStudyError = true
                                        self.saveStudyErrorMessage = nil
                                    } catch let FieldBookError.nameConflictError(message) {
                                        self.saveStudyError = true
                                        self.saveStudyErrorMessage = message
                                    }
                                }
                            }).buttonStyle(.borderedProminent).padding(.bottom).disabled(self.savingStudy)
                            Spacer()
                        }
                    } else {
                        HStack {
                            if(self.saveStudyErrorMessage != nil) {
                                Text(self.saveStudyErrorMessage!)
                            } else {
                                Text("Error saving study \"\(self.study.name)\"")
                            }
                        }.padding()
                    }
                }
            } else {
                ProgressView()
                Spacer()
            }
        }.task {
            await self.fetchStudyDetails()
        }
    }
    
    private func fetchStudyDetails() async {
        do {
            self.fetchStudyError = false
            self.studyDetails = try await brapiStudyService.fetchStudyDetails(studyDbId: self.study.studyDbId!, observationLevel: self.selectedObservationLevel)
        } catch {
            print("error fetching studyDetails: \(error.localizedDescription)")
            self.fetchStudyError = true
        }
        
        self.studyDetailsLoading = false
    }
    
    private func saveField() async throws {
        do {
            _ = try studyService.saveStudy(study: self.studyDetails!)
        } catch {
            throw error
        }
        self.savingStudy = false
    }
}

//struct BrAPIImportSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        BrapiStudyImportSheet(sheetName: "Test")
//        BrAPIPreviewField(studyTitle: "Phenotyping Fall 2021")
//    }
//}
