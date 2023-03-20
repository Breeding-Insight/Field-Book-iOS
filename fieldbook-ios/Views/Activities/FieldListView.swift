//
//  FieldListView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/6/21.
//

import SwiftUI

struct FieldListView: View {
    @EnvironmentObject private var appState: AppState
    @State private var showingImportAction = false
    @State private var studies: [Study] = []
    @State private var loadingStudies = true
    @State private var selectedStudy: Study = Study(name: "")
    
    private let studyService = InjectionProvider.getStudyService()
    
    enum SheetContent {
        case brapi, file, newField
    }
    
    @State private var sheetContent: SheetContent = .brapi
    @State private var showSheet = false
    
    var body: some View {
        VStack {
            if(!self.loadingStudies) {
                VStack {
                    if(studies.isEmpty) {
                        HStack {
                            Text("No fields currently exist, press the ") + Text(Image(systemName: "plus.circle.fill")).foregroundColor(.black)  + Text(" to get started")
                        }.padding(.leading).padding(.trailing)
                    } else {
                        Text("Select a field to collect data for").padding(.top)
                        List {
                            ForEach(studies, id: \.self.internalId) { study in
                                FieldListItem(study: study, selectedStudy: selectedStudy, selectedAction: {(listStudy) in
                                    self.selectedStudy.internalId = listStudy.internalId
                                    SettingsUtilities.setCurrentStudyId(self.selectedStudy.internalId!)
                                    appState.currentStudyId = self.selectedStudy.internalId!
                                    Task {
                                        await self.setActiveStudy()
                                    }
                                }, deleteSuccess: {(listStudy) in
                                    if(listStudy.internalId == selectedStudy.internalId) {
                                        selectedStudy.internalId = nil
                                        SettingsUtilities.setCurrentStudyId(nil)
                                        appState.currentStudyId = nil
                                        Task {
                                            await self.setActiveStudy()
                                        }
                                    }
                                    Task {
                                        await self.fetchStoredStudies()
                                    }
                                })
                            }
                        }
                        .listStyle(.plain)
                    }
                }.navigationTitle("Fields")
                    .navigationBarTitleDisplayMode(.inline)
                    .listStyle(.plain)
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button(action:{showingImportAction = true}, label: {
                                SwiftUI.Image(systemName: "plus.circle.fill").foregroundColor(.black)
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
                            }.sheet(isPresented: $showSheet, onDismiss: {
                                Task {
                                    await fetchStoredStudies()
                                }
                            }, content: {
                                switch sheetContent {
                                case .brapi: BrapiStudyImportSheet(sheetName: "BrAPI")
                                case .file: SheetView(sheetName: "File")
                                case .newField: FieldEditSheet(sheetName: "New field", study: nil)
                                }
                                
                            })
                        }
                    }
            } else {
                ProgressView()
            }
        }.task {
            await fetchStoredStudies()
        }
    }
    
    private func fetchStoredStudies() async {
        self.loadingStudies = true
        do {
            self.studies = try studyService.getAllStudies()
        } catch {
            //todo show error
        }
        self.loadingStudies = false
    }
    
    private func setActiveStudy() async {
        do {
            try studyService.setActiveStudy(appState.currentStudyId)
            print("active study set!")
        } catch {
            print("error setting active study: \(error.localizedDescription)")
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

struct FieldListItem: View {
    @State private var showingAction = false
    @State private var showingDeleteAlert = false
    @State private var showingSortSheet = false
    @State private var deleteError = false
    let study: Study
    @ObservedObject var selectedStudy: Study
    @State var selectedAction: (Study) -> Void
    let deleteSuccess: (Study) -> Void
    private let studyService = InjectionProvider.getStudyService()
    
    var body: some View {
        HStack {
            Button(action:{
                print("selecting study \(study.internalId!)")
                self.selectedAction(self.study)
            }, label: {
                SwiftUI.Image(systemName: (selectedStudy.internalId == study.internalId! ? "record.circle" : "circle"))
            })
            Text(self.study.name)
            Spacer()
            Text(SwiftUI.Image(systemName: "ellipsis")).rotationEffect(.degrees(90)).onTapGesture {
                self.showingAction = true
            }
            .alert("Delete Field?", isPresented: $showingDeleteAlert) {
                Button("No", role:.cancel) { }
                Button("Yes", role: .destructive) {
                    Task {
                        do {
                            try await self.deleteStudy()
                            self.deleteSuccess(self.study)
                        }  catch let FieldBookError.serviceError(message) {
                            print("error deleting study: \(String(describing: message))")
                            self.deleteError = true
                        }
                    }
                }
            }
            .alert(isPresented: $deleteError) {
                Alert(title: Text("Error"),
                      message: Text("Error removing study"),
                      dismissButton: .default(Text("OK")))
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
        }.onAppear() {
            selectedStudy.internalId = SettingsUtilities.getCurrentStudyId()
        }
    }
    
    private func deleteStudy() async throws {
        let removed = try studyService.deleteStudy([study.internalId!])
        if(removed == 0) {
            throw FieldBookError.serviceError(message: "Study wasn't removed")
        }
    }
}

struct FieldListView_Previews: PreviewProvider {
    static var previews: some View {
        FieldListView()
    }
}
