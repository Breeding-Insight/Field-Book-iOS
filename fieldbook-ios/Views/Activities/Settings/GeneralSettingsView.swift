//
//  GeneralSettingsView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 1/12/22.
//

import SwiftUI
import RadioGroup

struct GeneralSettingsView: View {
    private let importSources = ["Always Ask", "Local Storage", "Cloud Storage", "BrAPI"]
    private let exportSources = ["Always Ask", "Local Storage", "BrAPI"]
    
    @State private var showingImportSourceSheet = false
    @State private var importSource = 0;
    @State private var showingExportSourceSheet = false
    @State private var exportSource = 0;
    @State private var nextEntryNoData = false;
    @State private var moveViaBarcode = false;
    @State private var datagrid = false;
    @State private var moveUniqeId = false;
    
    var body: some View {
        List {
            ListItemWidget(rowIcon: "square.and.arrow.down", mainText: "Default import source", secondaryText: importSources[importSource], rightIcon: "chevron.right"
            ).onTapGesture {showingImportSourceSheet = true}
            .sheet(isPresented: $showingImportSourceSheet) {
                NavigationView {
                    VStack {
                        RadioGroupPicker(selectedIndex: $importSource, titles: importSources)
                            .selectedColor(.black)
                            .itemSpacing(15)
                            .titleColor(.black)
                            .titleAlignment(.right)
                            .fixedSize()
                            .padding(8)
                            .accentColor(.black)
                        
                        Button("Done") {
                            UserDefaults.standard.set(importSource, forKey: PreferenceConstants.DEFAULT_IMPORT_SOURCE)
                            showingImportSourceSheet = false
                        }.padding(.top)
                        Spacer()
                    }.padding()
                        .navigationBarTitle(Text("Set Default Import Source"), displayMode: .inline)
                        .navigationBarItems(leading: Button(action: {
                            importSource = UserDefaults.standard.integer(forKey:PreferenceConstants.DEFAULT_IMPORT_SOURCE)
                            showingImportSourceSheet = false
                        }) {
                            Text("Cancel").bold()
                        })
                }
            }
            ListItemWidget(rowIcon: "square.and.arrow.up", mainText: "Default export source", secondaryText: exportSources[exportSource], rightIcon: "chevron.right"
            ).onTapGesture {showingExportSourceSheet = true}
            .sheet(isPresented: $showingExportSourceSheet) {
                NavigationView {
                    VStack {
                        RadioGroupPicker(selectedIndex: $exportSource, titles: exportSources)
                            .selectedColor(.black)
                            .itemSpacing(15)
                            .titleColor(.black)
                            .titleAlignment(.right)
                            .fixedSize()
                            .padding(8)
                            .accentColor(.black)
                        
                        Button("Done") {
                            UserDefaults.standard.set(exportSource, forKey: PreferenceConstants.DEFAULT_EXPORT_SOURCE)
                            showingExportSourceSheet = false
                        }.padding(.top)
                        Spacer()
                    }.padding()
                        .navigationBarTitle(Text("Set Default Export Source"), displayMode: .inline)
                        .navigationBarItems(leading: Button(action: {
                            exportSource = UserDefaults.standard.integer(forKey:PreferenceConstants.DEFAULT_EXPORT_SOURCE)
                            showingExportSourceSheet = false
                        }) {
                            Text("Cancel").bold()
                        })
                }
            }
            ListItemWidget(rowIcon: "arrow.right", mainText: "Next entry with no data", secondaryText: "Adds a button to the toolbar that jumps to the next entry with no data for the current trait", rightIcon: nextEntryNoData ? "checkmark.square.fill" : "square"
            ).onTapGesture {
                nextEntryNoData = !nextEntryNoData
                UserDefaults.standard.set(nextEntryNoData, forKey: PreferenceConstants.NEXT_ENTRY_NO_DATA)
            }
            ListItemWidget(rowIcon: "barcode.viewfinder", mainText: "Move to entry via barcode", secondaryText: "Scan barcode and move to the specific entry", rightIcon: moveViaBarcode ? "checkmark.square.fill" : "square"
            ).onTapGesture {
                moveViaBarcode = !moveViaBarcode
                UserDefaults.standard.set(moveViaBarcode, forKey: PreferenceConstants.MOVE_VIA_BARCODE)
            }
            ListItemWidget(rowIcon: "rectangle.split.3x3", mainText: "Datagrid", secondaryText: "Displays a spreadsheet of plots and traits showing collected data", rightIcon: datagrid ? "checkmark.square.fill" : "square"
            ).onTapGesture {
                datagrid = !datagrid
                UserDefaults.standard.set(datagrid, forKey: PreferenceConstants.DATAGRID_DISPLAY)
            }
            ListItemWidget(rowIcon: "touchid", mainText: "Move to unique identifier", secondaryText: "Opens dialog to input unique id and move to specific entry", rightIcon: moveUniqeId ? "checkmark.square.fill" : "square"
            ).onTapGesture {
                moveUniqeId = !moveUniqeId
                UserDefaults.standard.set(moveUniqeId, forKey: PreferenceConstants.MOVE_UNIQUE_ID)
            }
        }.listStyle(.plain).navigationTitle("General")
            .onAppear {
                importSource = UserDefaults.standard.integer(forKey: PreferenceConstants.DEFAULT_IMPORT_SOURCE)
                exportSource = UserDefaults.standard.integer(forKey:PreferenceConstants.DEFAULT_EXPORT_SOURCE)
                nextEntryNoData = UserDefaults.standard.bool(forKey:PreferenceConstants.NEXT_ENTRY_NO_DATA)
                moveViaBarcode = UserDefaults.standard.bool(forKey:PreferenceConstants.MOVE_VIA_BARCODE)
                datagrid = UserDefaults.standard.bool(forKey:PreferenceConstants.DATAGRID_DISPLAY)
                moveUniqeId = UserDefaults.standard.bool(forKey:PreferenceConstants.MOVE_UNIQUE_ID)
            }
    }
}

struct GeneralSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsView()
    }
}
