//
//  AppearanceSettingsView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 1/12/22.
//

import SwiftUI

struct AppearanceSettingsView: View {
    @State private var showTutorial = false
    
    @State private var showingToolbarIconSheet = false
    @State private var toolbarIconSearch = false
    @State private var toolbarIconResources = false
    @State private var toolbarIconSummary = false
    @State private var toolbarIconLock = false
    
    @State private var showingNumInfoBarsSheet = false
    @State private var numInfoBars = 2
    
    func setTutorialState() -> Void {
        showTutorial = UserDefaults.standard.bool(forKey: PreferenceConstants.SHOW_TUTORIALS)
    }
    
    func setToolbarState() -> Void {
        toolbarIconSearch = UserDefaults.standard.bool(forKey:PreferenceConstants.CUSTOM_TOOLBAR_SEARCH)
        toolbarIconResources = UserDefaults.standard.bool(forKey:PreferenceConstants.CUSTOM_TOOLBAR_RESOURCES)
        toolbarIconSummary = UserDefaults.standard.bool(forKey:PreferenceConstants.CUSTOM_TOOLBAR_SUMMARY)
        toolbarIconLock = UserDefaults.standard.bool(forKey:PreferenceConstants.CUSTOM_TOOLBAR_LOCK)
    }
    
    func setInfoBarsState() -> Void {
        numInfoBars = UserDefaults.standard.integer(forKey: PreferenceConstants.NUM_INFO_BARS)
        if(numInfoBars == 0) {
            numInfoBars = 2
        }
    }
    
    var body: some View {
        List {
            Section(header: Text("Application").foregroundColor(.brown)) {
                //TODO - implement later
//                ListItemWidget(rowIcon: "paintpalette.fill", mainText: "Theme", secondaryText: "Modify specific colors or the entire theme of Field Book", rightIcon: "chevron.right"
//                )
//                ListItemWidget(rowIcon: "globe", mainText: "Language", secondaryText: "Language set by system", rightIcon: "chevron.right"
//                )
                ListItemWidget(rowIcon: "questionmark.circle.fill", mainText: "Tutorial", secondaryText: "Adds a tutorial icon to the collection, settings, fields, and traits screens", rightIcon: showTutorial ? "checkmark.square.fill" : "square"
                ).onTapGesture {
                    showTutorial = !showTutorial
                    UserDefaults.standard.set(showTutorial, forKey: PreferenceConstants.SHOW_TUTORIALS)
                }
            }
            Section(header: Text("Collect Screen").foregroundColor(.brown)) {
                ListItemWidget(rowIcon: "platter.2.filled.ipad.landscape", mainText: "Customize toolbar icons", secondaryText: "Modify default icons on the collect screen", rightIcon: "chevron.right"
                ).onTapGesture {showingToolbarIconSheet = true}
                .sheet(isPresented: $showingToolbarIconSheet) {
                    NavigationView {
                        VStack {
                            HStack {
                                SwiftUI.Image(systemName: toolbarIconSearch ? "checkmark.square.fill" : "square").padding(.trailing)
                                
                                Text("Search")
                            }.onTapGesture {
                                toolbarIconSearch = !toolbarIconSearch
                            }
                            
                            HStack {
                                SwiftUI.Image(systemName: toolbarIconResources ? "checkmark.square.fill" : "square").padding(.trailing)
                                
                                Text("Resources")
                            }.onTapGesture {
                                toolbarIconResources = !toolbarIconResources
                            }
                            
                            HStack {
                                SwiftUI.Image(systemName: toolbarIconSummary ? "checkmark.square.fill" : "square").padding(.trailing)
                                
                                Text("Summary")
                            }.onTapGesture {
                                toolbarIconSummary = !toolbarIconSummary
                            }
                            
                            HStack {
                                SwiftUI.Image(systemName: toolbarIconLock ? "checkmark.square.fill" : "square").padding(.trailing)
                                
                                Text("Lock")
                            }.onTapGesture {
                                toolbarIconLock = !toolbarIconLock
                            }
                            
                            Button("Done") {
                                UserDefaults.standard.set(toolbarIconSearch, forKey: PreferenceConstants.CUSTOM_TOOLBAR_SEARCH)
                                UserDefaults.standard.set(toolbarIconResources, forKey: PreferenceConstants.CUSTOM_TOOLBAR_RESOURCES)
                                UserDefaults.standard.set(toolbarIconSummary, forKey: PreferenceConstants.CUSTOM_TOOLBAR_SUMMARY)
                                UserDefaults.standard.set(toolbarIconLock, forKey: PreferenceConstants.CUSTOM_TOOLBAR_LOCK)
                                showingToolbarIconSheet = false
                            }.padding(.top)
                            Spacer()
                        }.padding()
                            .navigationBarTitle(Text("Customize Toolbar Icons"), displayMode: .inline)
                            .navigationBarItems(leading: Button(action: {
                                setToolbarState()
                                showingToolbarIconSheet = false
                            }) {
                                Text("Cancel").bold()
                            })
                    }
                }
                ListItemWidget(rowIcon: "text.badge.plus", mainText: "Number of InfoBars", secondaryText: "Adjust the number of Infobars displayed on the main screen", rightIcon: "chevron.right"
                ).onTapGesture {showingNumInfoBarsSheet = true}
                .sheet(isPresented: $showingNumInfoBarsSheet) {
                    NavigationView {
                        VStack {
                            HStack {
                                Text("The number of info bars displayed on the collect screen").padding(.trailing)
                                Picker("Number of info bars", selection: $numInfoBars) {
                                    Text("1").tag(1)
                                    Text("2").tag(2)
                                    Text("3").tag(3)
                                    Text("4").tag(4)
                                    Text("5").tag(5)
                                }
                            }
                            
                            Button("Done") {
                                UserDefaults.standard.set(numInfoBars, forKey: PreferenceConstants.NUM_INFO_BARS)
                                
                                showingNumInfoBarsSheet = false
                            }.padding(.top)
                            Spacer()
                        }.padding()
                            .navigationBarTitle(Text("Num Info Bars"), displayMode: .inline)
                            .navigationBarItems(leading: Button(action: {
                                setInfoBarsState()
                                showingNumInfoBarsSheet = false
                            }) {
                                Text("Cancel").bold()
                            })
                    }
                }
            }
        }.listStyle(.plain).navigationTitle("Appearance")
            .onAppear {
                setTutorialState()
                setToolbarState()
                setInfoBarsState()
            }
    }
}

struct AppearanceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceSettingsView()
    }
}
